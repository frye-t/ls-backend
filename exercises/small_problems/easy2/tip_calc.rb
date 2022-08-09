print "What is the bill? "
bill = gets.chomp.to_f

print "What is the tip percentage? "
tip_percent = gets.chomp.to_f / 100

tip_amount = (bill * tip_percent).round(2)
bill_total = (bill + tip_amount).round(2)

puts "\nThe tip is $#{format("%.2f", tip_amount)}"
puts "The total is $#{format("%.2f", bill_total)}"