module SystemConfig
  module Accessors
  end

  extend Accessors

  module_function def load!
    File.open('/etc/setup.conf') do |f|
      f.each_line do |line|
        next if line =~ /^\s*#/

        k, v = line.split('=', 2)
        k.strip!
        _v = v.strip

        Accessors.define_method(k) do
          _v
        end
      end
    end
  end
end

SystemConfig.load!
