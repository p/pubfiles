# frozen_string_literal: true

autoload :Shellwords, 'shellwords'

module Disk; end
module Disk::Helpers
  module_function def resolve_whole_device(device)
    if device =~ /\A(sd[a-z])\d+\z/
      # Use whole drive device, not partition
      device = $1
    end

    if device =~ /\A\w+\z/
      device = "/dev/#{device}"
    end

    unless File.exist?(device)
      raise Errno::EEXIST, "Device does not exist: #{device}"
    end

    device
  end

  module_function def free_space_in_path(path)
    output = `df #{Shellwords.shellescape(path)}`
    if output.empty?
      return nil
    end
    value = output.split("\n")[1].split(/\s+/)[3]
    1024 * Integer(value)
  end
end
