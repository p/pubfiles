# frozen_string_literal: true

module Disk; end
class Disk::Info
  def self.all(nvme: true, sd: true)
    patterns = []
    if nvme
      patterns << '/dev/nvme?n?'
    end
    if sd
      patterns << '/dev/sd?'
    end
    if patterns.empty?
      raise ArgumentError, 'Nothing to do'
    end

    disk_devices = patterns.map do |pattern|
      Dir[pattern]
    end.flatten.sort

    disk_devices.map do |device_name|
      new(device_name)
    end
  end

  def initialize(device_name)
    @device_name = device_name
  end

  attr_reader :device_name

  def partition_device_names
    Dir[partition_pattern].sort
  end

  def size
    fdisk_status[:size]
  end

  def model
    smartctl_status[:model] || fdisk_status[:model]
  end

  def serial
    smartctl_status[:serial]
  end

  def scsi?
    device_name=~ /\bsd/
  end

  def short_name
    File.basename(device_name)
  end

  def scsi_id
    @scsi_id ||= begin
      if scsi?
        File.basename(File.readlink("/sys/block/#{short_name}/device"))
      else
        raise ArgumentError, 'Device is not a SCSI disk'
      end
    end
  end

  private

  def partition_pattern
    if device_name =~ /\bnvme/
      "#{device_name}p?"
    else
      "#{device_name}?"
    end
  end

  def fdisk_status
    @fdisk_status ||= {}.tap do |status|
      output = `fdisk -l #{device_name}`.strip

      unless output.empty?
        status[:size] = "#{output.split(/\s+/)[2]} #{output.split(/\s+/)[3].sub(',', '')}"
        if output =~ /Disk model: ([^\n]+)/
          status[:model] = $1
        end
      end

      status.freeze
    end
  end

  def smartctl_status
    @smartctl_status ||= {}.tap do |status|
      output = `smartctl -a #{device_name}`

      if output =~ /Serial [nN]umber:\s+(\S+)/
        status[:serial] = $1
      end
      if output =~ /Device Model:\s+(.+?)\n/
        status[:model] = $1
      end

      status.freeze
    end
  end
end
