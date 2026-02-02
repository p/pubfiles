# frozen_string_literal: true

module FormatHelpers
  module_function

  SIZE_UNITS = %w(bytes KB MB GB TB)
  SHORT_SIZE_UNITS = %w(B KB MB GB TB)

  def friendly_size(size, suffix: nil, short: false, align: false, integer: false)
    units = short ? SHORT_SIZE_UNITS : SIZE_UNITS
    unit_formatter = align ? '%2s' : '%s'

    if size.respond_to?(:nan?) && size.nan?
      return "-- #{unit_formatter % units.first}#{suffix}"
    end

    if size == 0
      return "0 #{unit_formatter % units.first}#{suffix}"
    end

    units.each do |unit|
      if size < 5*1024
        if integer
          precision = 0
        else
          precision = [2-size.round.to_s.length, 0].max
        end
        return "#{"%.#{precision}f" % size} #{unit_formatter % unit}#{suffix}"
      end

      size /= 1024.0
    end

    precision = [2-size.round.to_s.length, 0].max
    "#{"%.#{precision}f" % size} PB#{suffix}"
  end

  def size_in_kb(size, suffix: nil, integer: false)
    unit = "KB#{suffix}"

    if size.respond_to?(:nan?) && size.nan?
      return "-- #{unit}"
    end

    if size == 0
      return "0 #{unit}"
    end

    size /= 1024.0

    if integer
      precision = 0
    else
      precision = [2-size.round.to_s.length, 0].max
    end
    return "#{"%.#{precision}f" % size} #{unit}"
  end

  TIME_UNITS = [
    ['seconds', 60],
    ['minutes', 60],
    ['hours', 24],
    ['days', 1_000_000],
  ]

  SHORT_TIME_UNITS = [
    ['sec', 60, 90],
    ['min', 60, 90],
    ['hr', 24, 36],
    ['day', 1, 1_000_000],
  ]

  def friendly_time(time, short: false)
    units = short ? SHORT_TIME_UNITS : TIME_UNITS
    units.each do |(unit, divisor, max)|
      if time < max
        precision = if %w(sec seconds).include?(unit)
          0
        else
          [2-time.round.to_s.length, 0].max
        end
        return "#{"%.#{precision}f" % time} #{unit}"
      end

      time /= divisor.to_f
    end

    raise "Should never get here"
  end
end
