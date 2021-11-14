module Convertable
  def unix_to_readable_date(unix_dt)
    dt = Time.at(unix_dt).to_datetime
    dt.strftime("%Y-%m-%d")
  end

  def unix_to_readable_datetime(unix_dt)
    dt = Time.at(unix_dt).to_datetime
    dt.strftime("%Y-%m-%d %H:%M:%S %z")
  end

  def unix_to_readable_time(unix_dt)
    dt = Time.at(unix_dt).to_datetime
    dt.strftime("%H:%M:%S")
  end
end
