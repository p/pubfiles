#!/usr/bin/env ruby

require 'optparse'
autoload :FileUtils, 'fileutils'
autoload :Etc, 'etc'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: install [options]"

  opts.on("-c", "--copy", "Copy files instead of symlinking them") do
    options[:copy] = true
  end
end.parse!

class Installer
  def initialize(**opts)
    @options = opts.dup.freeze
  end

  attr_reader :options

  def run
    mkdir_p('~/bin')

    if have?('zsh')
      install_file('home/zshenv', '~/.zshenv')

      dest = expand_dest('~/.zshrc')
      unless File.exist?(dest)
        cp('home/zshrc.sample', dest)
      end
    end

    if have?('git')
      install_file('home/gitconfig', '~/.gitconfig')
      install_file('home/gitignore', '~/.gitignore')
    end

    install_file('home/irbrc', '~/.irbrc')
    install_file('home/gemrc', '~/.gemrc')
    install_file('home/bundle/config', '~/.bundle/config')

    if headful?
      mkdir_p('~/.config/gtk-2.0')

      install_file('home/config/user-dirs.dirs', '~/.config/user-dirs.dirs')
      # This file is mutated in operation, in particular comments are trashed.
      cp('home/config/gtk-2.0/gtkfilechooser.ini', '~/.config/gtk-2.0/gtkfilechooser.ini')

      if %w(me w).include?(Etc.getlogin)
        # xinitrc.tpl
        rm_f('~/.xinitrc')
      end

      if have?('xscreensaver')
        install_file('home/xscreensaver', '~/.xscreensaver')
      end

      install_file('home/SciTEUser.properties', '~/.SciTEUser.properties')
      install_file('home/gtkterm2rc', '~/.gtkterm2rc')
      install_file('home/gtkrc-2.0', '~/.gtkrc-2.0')

      if File.exist?('/usr/sbin/pm-suspend')
        ln_sf('/usr/sbin/pm-suspend', '~/bin/pm-suspend')
      end
    end
  end

  private

  def config
    @config ||= {}.tap do |config|
      File.open('/etc/setup.conf') do |f|
        f.each_line do |line|
          if line =~ /\A\s*#/
            next
          end
          k, v = line.strip.split('=', 2)
          config[k] = case v
            when 'true'
              true
            when 'false'
              false
            when''
              false
            else
              v
            end
        end
      end
    end
  end

  def pub_root
    @pub_root ||= File.realpath(File.dirname(__FILE__))
  end

  def have?(bin)
    ENV['PATH'].split(':').any? { |path| File.exist?(File.join(path, bin)) }
  end

  def laptop?
    if have?('laptop-detect')
      system('laptop')
    else
      false
    end
  end

  def headful?
    config.fetch('headful', laptop?)
  end

  def expand_dest(path)
    File.expand_path(path)
  end

  def expand_src(path)
    File.join(pub_root, path)
  end

  def maybe_expand_src(src)
    if src[0] == ?/
      src
    else
      expand_src(src)
    end
  end

  def maybe_expand_dest(dest)
    if dest[0] == ?=
      dest
    else
      File.expand_path(dest)
    end
  end

  def install_file(src, dest)
    src = maybe_expand_src(src)
    dest = maybe_expand_dest(dest)
    if options[:copy]
      FileUtils.cp(src, dest)
    else
      FileUtils.ln_sf(src, dest)
    end
  end

  def cp(src, dest)
    FileUtils.cp(maybe_expand_src(src), maybe_expand_dest(dest))
  end

  %i(mkdir mkdir_p rm_f).each do |meth|
    define_method(meth) do |path|
      FileUtils.public_send(meth, maybe_expand_dest(path))
    end
  end

  def ln_sf(src, dest)
    FileUtils.ln_sf(src, maybe_expand_dest(dest))
  end
end

Installer.new(**options).run
