# class DateTime
#   def self.random from = DateTime., to = DateTime.now
#     DateTime.at(from + rand * (to.to_time.to_f - from.to_time.to_f))
#   end
# end


class Time
  def to_datetime
    # Convert seconds + microseconds into a fractional number of seconds
    seconds = sec + Rational(usec, 10**6)

    # Convert a UTC offset measured in minutes to one measured in a
    # fraction of a day.
    offset = Rational(utc_offset, 60 * 60 * 24)
    DateTime.new(year, month, day, hour, min, seconds, offset)
  end

  def self.random from=0.0, to=Time.now
    Time.at(rand * (to.to_f - from.to_f) + from.to_f).to_datetime
  end

end