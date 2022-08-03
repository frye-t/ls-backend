=begin

# Q2
md = "The Munsters are creepy in a good way."

p md.swapcase
p md.capitalize
p md.downcase
p md.upcase

# Q3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }

additional_ages = { "Marilyn" => 22, "Spot" => 237 }
p ages.merge!(additional_ages)
p ages
p additional_ages

# Q4
advice = "Few things in life are as important as house training your pet dinosaur."
p advice.include?("dino")
p advice.match?("Dino")

# Q5
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones

# Q6
flintstones << 'Dino'
p flintstones

# Q7
flintstones.pop
flintstones.concat( %w(Dino Hoppy) )
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.push("Dino", "Hoppy")
p flintstones

# Q8
advice = "Few things in life are as important as house training your pet dinosaur."

p advice.slice(0,advice.index("house"))
p advice

# Q9
statement = "The Flintstones Rock!"
p statement.count('t')

# Q10
title = "Flintstone Family Members"
#((40 / 2) - (title.size / 2)).times{title.prepend(" ")}
puts title.center(40)
puts "........................................"
=end