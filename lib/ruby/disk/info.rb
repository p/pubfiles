# frozen_string_literal: true

autoload :JSON, 'json'

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

  def self.background_scan_log_entries(device_name)
    output = `smartctl --log=background -j #{device_name}`
    raise "Smartctl failed for #{device_name}" unless $?.exitstatus == 0
    info = JSON.parse(output, symbolize_names: true).fetch(:scsi_background_scan)
    info.select do |(key, v)|
      key.start_with?('result_')
    end.values
  end

  def initialize(device_name)
    @device_name = device_name
  end

  attr_reader :device_name

  def partition_device_names
    Dir[partition_pattern].sort
  end

  def size
    smartctl_status.dig(:user_capacity, :bytes)
  end

  def model
    smartctl_status.fetch(:model_name)
  end

  def serial
    smartctl_status.fetch(:serial_number)
  end

  def logical_block_size
    smartctl_status.fetch(:logical_block_size)
  end

  def block_size
    logical_block_size
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

  # @return "disk" | "part" | "crypt"
  def type
    lsblk_status.fetch(:type)
  end

  def label
    lsblk_status.fetch(:label)
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
    @smartctl_status ||= begin
      output = `smartctl -ji #{device_name}`
      raise "Smartctl failed for #{device_name}" unless $?.exitstatus == 0
      JSON.parse(output, symbolize_names: true)
    end
  end

  def lsblk_status
    @lsblk_status ||= begin
      output = `lsblk -Jdo TYPE,LABEL #{device_name}`
      raise "lsblk failed for #{device_name}" unless $?.exitstatus == 0
      JSON.parse(output, symbolize_names: true).fetch(:blockdevices).first
    end
  end
end
