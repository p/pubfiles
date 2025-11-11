class SmartInfo
  def initialize(text)
    text.split("\n").each do |line|
      case line
      when /\ALocal Time is:(.+)/
        @time = Time.parse($1)
      when /\Aread:/
        values = line.split(/\s+/)
        @read_corrected_fast = Integer(values[1])
        @read_corrected_delayed = Integer(values[2])
        @rereads = Integer(values[3])
        @read_corrected = Integer(values[4])
        @read_correction_invocations = Integer(values[5])
        @read_bytes_processed = (Float(values[6]) * 10**9).to_i
        @read_uncorrected = Integer(values[7])
      when /\Awrite:/
        values = line.split(/\s+/)
        @write_corrected_fast = Integer(values[1])
        @write_corrected_delayed = Integer(values[2])
        @rewrites = Integer(values[3])
        @write_corrected = Integer(values[4])
        @write_correction_invocations = Integer(values[5])
        @write_bytes_processed = (Float(values[6]) * 10**9).to_i
        @write_uncorrected = Integer(values[7])
      when /\Averify:/
        values = line.split(/\s+/)
        @verify_corrected_fast = Integer(values[1])
        @verify_corrected_delayed = Integer(values[2])
        @reverifys = Integer(values[3])
        @verify_corrected = Integer(values[4])
        @verify_correction_invocations = Integer(values[5])
        @verify_bytes_processed = (Float(values[6]) * 10**9).to_i
        @verify_uncorrected = Integer(values[7])
      end
    end
  end

  attr_reader :time
  attr_reader :read_corrected_fast, :read_corrected_delayed,
    :rereads, :read_corrected, :read_correction_invocations,
    :read_bytes_processed, :read_uncorrected
  attr_reader :write_corrected_fast, :write_corrected_delayed,
    :rewrites, :write_corrected, :write_correction_invocations,
    :write_bytes_processed, :write_uncorrected
  attr_reader :verify_corrected_fast, :verify_corrected_delayed,
    :reverifys, :verify_corrected, :verify_correction_invocations,
    :verify_bytes_processed, :verify_uncorrected
end
