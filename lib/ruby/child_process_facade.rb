#gem 'childprocess'
autoload :ChildProcess, 'childprocess'
autoload :Tempfile, 'tempfile'
autoload :Etc, 'etc'

module ChildProcessFacade
  class CalledProcessError < StandardError
  end

  # Uniform result for both spawn paths
  Result = Struct.new(:exit_code) do
    def success?
      exit_code == 0
    end
  end

  module_function def uncheck_call(cmd, env: nil, stdin_data: nil, user: nil)
    if user
      puts "[CPF] Starting as #{user}: #{cmd.join(' ')}"
      user_info = Etc.getpwnam(user)
      pid = fork do
        # Set supplementary groups, then gid, then uid
        Process.initgroups(user, user_info.gid)
        Process::GID.change_privilege(user_info.gid)
        Process::UID.change_privilege(user_info.uid)
        Dir.chdir(user_info.dir)
        env&.each { |k, v| ENV[k.to_s] = v }
        exec(*cmd)
      end
      _, status = Process.wait2(pid)
      Result.new(status.exitstatus)
    else
      start_process(cmd, env: env, stdin_data: stdin_data).tap do |process|
        process.wait
      end
    end
  end

  module_function def start_and_forward(cmd, env: nil)
    puts "[CPF] Starting: #{cmd.join(' ')}"
    process = ChildProcess.new(*cmd)
    process.io.inherit!
    rd, wr = IO.pipe
    apply_env(process, env)
    process.start
    p process.wait
  end

  module_function def check_call(cmd, env: nil, stdin_data: nil, user: nil)
    result = uncheck_call(cmd, env: env, stdin_data: stdin_data, user: user)
    check_exit_code(result, cmd)
  end

  module_function def check_output(cmd, env: nil)
    puts "[CPF] Get output: #{cmd.join(' ')}"
    process = ChildProcess.new(*cmd)
    process.io.inherit!
    process.io.stdout = Tempfile.new("child-output")
    process.io.stderr = Tempfile.new("child-error")
    begin
      apply_env(process, env)
      process.start
      process.wait
      check_exit_code(process, cmd)
      process.io.stdout.rewind
      process.io.stdout.read
    ensure
      process.io.stdout.close
      process.io.stderr.close
    end
  end

  module_function def start_process(cmd, env: nil, stdin_data: nil)
    puts "[CPF] Starting: #{cmd.join(' ')}"
    process = ChildProcess.new(*cmd)
    if stdin_data
      process.duplex = true
      process.io.stdout = STDOUT
      process.io.stderr = STDERR
    else
      process.io.inherit!
    end
    apply_env(process, env)
    process.start
    if stdin_data
      process.io.stdin << stdin_data
      process.io.stdin.close
    end
    process
  end

  module_function def start_process_pipe(cmd, env: nil)
    puts "[CPF] Starting pipe: #{cmd.join(' ')}"
    rd, wr = IO.pipe
    pid = fork do
      rd.close
      STDOUT.reopen(wr)
      STDERR.reopen(wr)
      wr.close

      if env
        env.each do |k, v|
          ENV[k] = v
        end
      end

      exec(*cmd)
    end

    wr.close
    cmd_name = File.basename(cmd.first)
    thread = Thread.new do
      loop do
        chunk = rd.readline
        if chunk.nil?
          break
        end
        STDOUT << "[#{cmd_name}] #{chunk}"
      rescue EOFError
        # swallow
      end
    end

    {pid: pid, thread: thread}
  end

  private

  module_function def apply_env(process, env)
    if env
      env.each do |k, v|
        process.environment[k.to_s] = v
      end
    end
  end

  module_function def format_cmd(cmd)
    cmd.join(' ')
  end

  module_function def check_exit_code(process, cmd)
    unless process.exit_code == 0
      raise CalledProcessError, "Failed to execute: #{format_cmd(cmd)} (exit code #{process.exit_code})"
    end
  end
end
