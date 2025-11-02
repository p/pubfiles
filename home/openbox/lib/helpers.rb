autoload :Find, 'find'
autoload :YAML, 'yaml'
autoload :Socket, 'socket'
autoload :Shellwords, 'shellwords'
autoload :Timeout, 'timeout'
autoload :JSON, 'json'
autoload :Pathname, 'pathname'
require 'open-uri'

module PathHelpers
  def fox_launcher_path
    File.realpath(File.expand_path('~/apps/brl/bin/launch-fox'))
  end

end

module Helpers
  include GlobalHelpers

  def src_base
    @src_base ||= Pathname.new(__FILE__).dirname.join('..')
  end

  def fox_browsers
    @fox_browsers ||= [].tap do |br|
      if have?('waterfox-classic')
        br << waterfox_classic
      end
      if have?('waterfox')
        br << waterfox
      end
      if have?('firefox')
        br << firefox
      end
    end
  end

  def waterfox_classic
    #@waterfox ||= Browser.new('waterfox', 'Waterfox', '/opt/waterfox-classic/waterfox')
    @waterfox_classic ||= Browser.new('waterfox-classic', 'Waterfox Classic', 'waterfox-classic')
  end

  def waterfox
    #@waterfox ||= Browser.new('waterfox', 'Waterfox', '/opt/waterfox-classic/waterfox')
    @waterfox ||= Browser.new('waterfox', 'Waterfox', 'waterfox')
  end

  def firefox
    @firefox ||= Browser.new('firefox', 'Firefox', 'firefox')
  end

  def hostname
    @hostname ||= Socket.gethostname
  end

  def x_sudo(user)
    "sudo -u #{user} env XAUTHORITY=/home/#{user}/.Xauthority"
  end

  def x_firefox_path
    ENV.fetch('PATH').split(':').each do |dir|
      path = File.join(dir, 'firefox')
      if File.exist?(path)
        return path
      end
    end
    raise "No firefox in PATH"
  end

  def browser_accounts
    @browser_accounts ||= [].tap do |br|
      conf_dir = File.join(File.dirname(__FILE__), '..', 'browser-accounts.d')
      Find.find(conf_dir) do |path|
        if path.end_with?('.yml')
          infos = File.open(path) do |f|
            YAML.load(f)
          end
          infos.values.each do |info|
            user_suffix = info.fetch('user-suffix')
            if info['if-user-exists'] && !have_user?("br-#{user_suffix}")
              next
            end
            br << BrowserAccount.new(
              info.fetch('name'),
              user_suffix,
              nil,
              info['tamper-monkey'],
              options[:verbose_browsers],
            )
          end
        end
      end
    end
  end

  def lock_command(*args)
    cmd = %w(
      env XSECURELOCK_PASSWORD_PROMPT=asterisks
        XSECURELOCK_SHOW_HOSTNAME=1
        XSECURELOCK_SHOW_USERNAME=1
      xsecurelock)
    if args.any?
      cmd << '--'
      cmd += args
    end
    array_to_cmd(cmd)
  end

  def lock_and_suspend_command
    lock_command('sudo', '-n', 'pm-suspend')
  end

  def array_to_cmd(bits)
    bits.map do |bit|
      Shellwords.escape(bit)
    end.join(' ')
  end

  def command_action(str)
    %Q,
      <action name="Execute"><command>
        #{str}
      </command></action>
    ,
  end

  def default_terminal
    %w(x-terminal-emulator gtkterm2 gnome-terminal urxvt xterm).each do |prog|
      if have?(prog)
        return prog
      end
    end
    raise "No suitable terminal emulator"
  end
end
