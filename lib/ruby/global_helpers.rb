autoload :Etc, 'etc'

module GlobalHelpers

  def have?(bin)
    ENV.fetch('PATH').split(':').any? { |path| File.exist?(File.join(path, bin)) }
  end

  def have_user?(username)
    Etc.getpwnam(username)
    true
  rescue ArgumentError
    false
  end

  def laptop?
    if have?('laptop-detect')
      system('laptop-detect')
    else
      false
    end
  end

  def monotime
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end
end
