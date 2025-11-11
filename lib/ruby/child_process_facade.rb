#gem 'childprocess'
autoload :ChildProcess, 'childprocess'

module ChildProcessFacade
  class CalledProcessError < Error
  end

  module_function def uncheck_call(cmd, env: nil)
    start_process(cmd, env: env).tap do |process|
      process.wait
    end
  end

  module_function def start_and_forward(cmd, env: nil)
    puts "[CWR] Starting: #{cmd.join(' ')}"
    process = ChildProcess.new(*cmd)
    process.io.inherit!
    rd, wr = IO.pipe
    apply_env(process, env)
    process.start
    p process.wait
  end

  module_function def check_call(cmd, env: nil)
    process = uncheck_call(cmd, env: env)
    check_exit_code(process, cmd)
  end

  module_function def check_output(cmd, env: nil)
    puts "[CWR] Get output: #{cmd.join(' ')}"
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

  module_function def start_process(cmd, env: nil)
    puts "[CWR] Starting: #{cmd.join(' ')}"
    process = ChildProcess.new(*cmd)
    process.io.inherit!
    apply_env(process, env)
    process.start
    process
  end

  module_function def start_process_pipe(cmd, env: nil)
    puts "[CWR] Starting pipe: #{cmd.join(' ')}"
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
