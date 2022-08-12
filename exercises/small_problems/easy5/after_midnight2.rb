MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24
MINUTES_PER_DAY = MINUTES_PER_HOUR * HOURS_PER_DAY

def after_midnight(time_str)
  hr, min = time_str.split(':').map(&:to_i)
  (hr * MINUTES_PER_HOUR + min) % MINUTES_PER_DAY
end

def before_midnight(time_str) 
  (MINUTES_PER_DAY - after_midnight(time_str)) % MINUTES_PER_DAY
end

p after_midnight('00:00') == 0
p before_midnight('00:00') == 0
p after_midnight('12:34') == 754
p before_midnight('12:34') == 686
p after_midnight('24:00') == 0
p before_midnight('24:00') == 0
