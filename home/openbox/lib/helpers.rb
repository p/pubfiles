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
      br << BrowserAccount.new('Sandbox', 'sandbox', nil)
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

  def array_to_cmd(bits)
    bits.map do |bit|
      Shellwords.escape(bit)
    end.join(' ')
  end
end
