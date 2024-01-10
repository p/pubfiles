require 'tempfile'
autoload :Pathname, 'pathname'

class SystemConfigurationError < StandardError
end

class Builder
  include Helpers
  include PathHelpers

  def initialize(**opts)
    @options = opts
  end

  attr_reader :options

  def check
    unless have?('yad')
      raise SystemConfigurationError, "yad missing"
    end

    unless system("#{fox_launcher_path} -h")
      raise SystemConfigurationError, "Fox launcher is not working"
    end
  end

  def build
    if options[:check]
      check
    end

    Dir.mktmpdir do |dir|
      files = %w(rc.xml menu.xml)
      files.each do |file|
        transform_template(file, dir)
      end
      files.each do |file|
        install_file(file, dir)
      end
    end
  end

  def transform_template(basename, dest_dir)
    if File.exist?(template_path = src_base.join(basename + '.erb'))
      result = Context.new.render(template_path)
      File.open(tmp_rc_path = File.join(dest_dir, basename), 'w') do |f|
        f << result
      end
    else
      FileUtils.cp(src_base.join(basename), dest_dir)
    end
  end

  def install_file(basename, tmp_dir)
    FileUtils.mkdir_p(openbox_rc_root)
    FileUtils.cp(File.join(tmp_dir, basename), openbox_rc_root.join(basename))
  end

  def openbox_rc_root
    if path = ENV['XDG_CONFIG_HOME']
    else
      path = File.expand_path('~/.config')
      #raise "XDG_CONFIG_HOME not set"
    end
    Pathname.new(path).join('openbox')
  end

  def reload
    output = `openbox --reconfigure`
    if $?.exitstatus != 0
      puts output
      raise "Failed to reconfigure openbox"
    end
  end
end
