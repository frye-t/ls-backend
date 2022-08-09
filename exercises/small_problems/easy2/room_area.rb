SQMETERS_TO_SQFEET = 10.7639

def find_area_meters(x, y)
  x * y
end

def convert_meter_to_feet(meters)
  meters * SQMETERS_TO_SQFEET
end

puts "Enter the length of the room in meters"
length = gets.chomp.to_f

puts "Enter the width of the room in meters"
width = gets.chomp.to_f

area_m = find_area_meters(length, width)
puts "The area of the room is #{area_m} square meters " + \
  "(#{convert_meter_to_feet(area_m)} square feet)."
