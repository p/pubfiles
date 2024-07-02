require 'tempfile'
autoload :Shellwords, 'shellwords'
autoload :FileUtils, 'fileutils'
autoload :Pathname, 'pathname'
begin
  require 'nokogiri'
  HAVE_NOKOGIRI = true
rescue LoadError => exc
  raise "Error loading nokogiri: #{exc.class}: #{exc}"
  HAVE_NOKOGIRI = false
end

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
    if File.exist?(template_path = src_base.join(template_name = basename + '.erb'))
      transform_template_real(basename, template_name, template_path, dest_dir)
    elsif File.exist?(template_path = src_base.join(template_name = basename + '.slim'))
      transform_template_real(basename, template_name, template_path, dest_dir)
    else
      FileUtils.cp(src_base.join(basename), dest_dir)
    end
  end

  def transform_template_real(basename, template_name, template_path, dest_dir)
    result = Context.new(**options).render(template_path)
    if HAVE_NOKOGIRI
      doc = Nokogiri::XML(result)
      unless doc.errors.empty?
        errors = doc.errors.map do |e|
          "#{e.class}: #{e}"
        end.join(', ')
        raise "#{template_name} generated malformed XML: #{errors}"
      end
    end
    tmp_rc_path = File.join(dest_dir, basename)
    if options[:pretty]
      File.open(tmp_rc_path + '.part', 'w') do |f|
        f << result
      end
      escaped = Shellwords.shellescape(tmp_rc_path)
      output = system("xmllint --format -o #{escaped} #{escaped}.part")
      if $?.exitstatus != 0
        raise "xmllint failed - not installed?\n#{output}"
        FileUtils.rm(tmp_rc_path + '.part')
      end
    else
      File.open(tmp_rc_path, 'w') do |f|
        f << result
      end
    end
  end

  def install_file(basename, tmp_dir)
    FileUtils.mkdir_p(openbox_rc_root)
    FileUtils.cp(File.join(tmp_dir, basename), openbox_rc_root.join(basename))
  end

  def openbox_rc_root
    if path = options[:dest_path]
      Pathname.new(path)
    else
      if path = ENV['XDG_CONFIG_HOME']
      else
        path = File.expand_path('~/.config')
        #raise "XDG_CONFIG_HOME not set"
      end
      Pathname.new(path).join('openbox')
    end
  end

  def reload
    output = `openbox --reconfigure`
    if $?.exitstatus != 0
      puts output
      raise "Failed to reconfigure openbox"
    end
  end
end
