# frozen_string_literal: true

SIZE_UNITS = %w(bytes KB MB GB TB)

def friendly_size(size, suffix: nil)
  if size.respond_to?(:nan?) && (size.nan? || size.infinite?)
    return "-- bytes#{suffix}"
  end

  SIZE_UNITS.each do |unit|
    if size < 5*1024
      precision = [2-size.round.to_s.length, 0].max
      return "#{"%.#{precision}f" % size} #{unit}#{suffix}"
    end

    size /= 1024.0
  end

  precision = [2-size.round.to_s.length, 0].max
  "#{"%.#{precision}f" % size} PB#{suffix}"
end

TIME_UNITS = [
  ['seconds', 60],
  ['minutes', 60],
  ['hours', 24],
  ['days', 1_000_000],
]

def friendly_time(time)
  TIME_UNITS.each do |(unit, max)|
    if time < max/2
      precision = [2-time.round.to_s.length, 0].max
      return "#{"%.#{precision}f" % time} #{unit}"
    end

    time /= max.to_f
  end

  raise "Should never get here"
end
