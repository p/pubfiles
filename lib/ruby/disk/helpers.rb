# frozen_string_literal: true

module Disk; end
module Disk::Helpers
  def self.resolve_whole_device(device)
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
end
