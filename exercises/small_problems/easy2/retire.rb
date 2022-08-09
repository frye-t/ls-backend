print "What is your age? "
age = gets.chomp.to_i

print "At what age would you like to retire? "
retire_age = gets.chomp.to_i

cur_year = Time.now.year
years_til_retire = retire_age - age

puts "\nIt's #{cur_year}. You will retire in #{cur_year + years_til_retire}"
puts "You only have #{years_til_retire} years of work to go!"