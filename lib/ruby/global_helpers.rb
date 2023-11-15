module GlobalHelpers

  def have?(bin)
    ENV.fetch('PATH').split(':').any? { |path| File.exist?(File.join(path, bin)) }
  end

  def laptop?
    if have?('laptop-detect')
      system('laptop-detect')
    else
      false
    end
  end
end
