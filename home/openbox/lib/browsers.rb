autoload :Pathname, 'pathname'

BrowserAccount = Struct.new('BrowserAccount',
  :name,
  :short_username,
  :profile_name,
  :verbose_browsers,
)

Browser = Struct.new('Browser',
  :id,
  :display_name,
  :path,
)

class BrowserAccount
  include PathHelpers

  def fox_command(browser)
      #-e ~/apps/brl/data/fox/latest/new_tab_homepage.xpi
    %Q,
      #{fox_launcher_path}
      -fgG
      -b #{browser.path}
      -S DuckDuckGo
      --user-js #{src_base}/../../home/mozilla/user.js
      --user-chrome-css #{src_base}/../../home/mozilla/userChrome.css
      --user-content-css #{src_base}/../../home/mozilla/userContent.css
      --policies #{src_base}/../../config/mozilla/distribution/policies.json
      -u #{short_username}
      -p #{profile_name || short_username}
    ,.gsub(/\s+/, ' ').strip.tap do |cmd|
      if verbose_browsers?
        puts "#{browser.display_name} - #{name}:\n#{cmd}"
      end
    end
  end

  def verbose_browsers?
    !!verbose_browsers
  end

  def src_base
    @src_base ||= Pathname.new(__FILE__).dirname.join('..').realpath
  end

  def chromium_command(browser = nil)
    binary_path = [
      '/usr/local/lib/brl/bin/launch-chromium',
      File.expand_path('~/apps/brl/bin/launch-chromium'),
    ].detect { |p| File.exist?(p) }
    if binary_path.nil?
      raise "No binary to launch"
    end
    cmd = [binary_path,
      '-G', '-f', '-u', short_username,
      chromium_options(profile_name || short_username),
      '-p', profile_name || short_username,
    ]
    if browser
      cmd += ['-b', browser]
    end
    cmd.join(' ').gsub(/\s+/, ' ').strip.tap do |cmd|
      if verbose_browsers?
        puts "Chromium - #{name}:\n#{cmd}"
      end
    end
  end

  def fresh_chromium_command(browser = nil)
    "#{chromium_command(browser)} -n -R"
  end

  def restore_chromium_command(browser = nil)
    "#{chromium_command(browser)} -r"
  end

  def chromium_options(profile_name)
    ''
  end
end
