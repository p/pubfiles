# frozen_string_literal: true

module Disk; end
class Disk::IOStats
  def initialize(device_name)
    @device_name = File.basename(device_name)
  end

  attr_reader :device_name

  def stats
    @stats ||= begin
      contents = File.read(File.join('/sys/block', device_name, 'stat'))
      contents.strip.split(%r,\s+,).map { |v| Integer(v) }
    end
  end

  def sector_size
    # I think it's always 512 regardless of file system block size
    512
  end

  def reads_completed
    stats[0]
  end

  def reads_merged
    stats[1]
  end

  def sectors_read
    stats[2]
  end

  def bytes_read
    sectors_read * sector_size
  end

  def milliseconds_spent_reading
    stats[3]
  end

  def time_spent_reading
    milliseconds_spent_reading / 1000.0
  end

  def writes_completed
    stats[4]
  end

  def writes_merged
    stats[5]
  end

  def sectors_written
    stats[6]
  end

  def bytes_written
    sectors_written * sector_size
  end

  def milliseconds_spent_writing
    stats[7]
  end

  def time_spent_writing
    milliseconds_spent_writing / 1000.0
  end

  def ios_in_progress
    stats[8]
  end

  def milliseconds_spent_current_io
    stats[9]
  end

  def weighted_milliseconds_spent_current_io
    stats[10]
  end

  def discards_completed
    stats[11]
  end

  def discards_merged
    stats[12]
  end

  def sectors_discarded
    stats[13]
  end

  def bytes_discarded
    sectors_discarded * sector_size
  end

  def milliseconds_spent_discarding
    stats[14]
  end

  def time_spent_discarding
    milliseconds_spent_discarding / 1000.0
  end

  def flushes_completed
    stats[15]
  end

  def milliseconds_spent_flushing
    stats[16]
  end

  def time_spent_flushing
    milliseconds_spent_flushing / 1000.0
  end
end
