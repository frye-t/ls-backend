# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# flintstones_hash = {}

# flintstones.each_with_index do |name, idx|
# 	flintstones_hash[name] = idx
# end

# p flintstones_hash

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# total_age = 0
# ages.each { |k, v| total_age += v }

# p ages.values.inject(:+)

# p total_age

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# ages.delete_if { |_, v| v >= 100 }
# ages.keep_if { |_, v| v < 100}
# p ages


# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# statement = "The Flintstones Rock"
# statement.delete!(' ')
# char_hash = {}

# statement.chars.each do |c|
# 	char_hash[c] = statement.count(c)
# end

# p char_hash.sort.to_h

# numbers = [1, 2, 3, 4]
# numbers.each_with_index do |number, index|
#   p "#{index}  #{numbers.inspect}  #{number}"
#   numbers.pop(1)
# end

# def titleize(str)
# 	str.split.map { |word| word.capitalize }.join(' ')
# end

# words = "the flintstones rock"
# words = titleize(words)
# p words

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, stats|
	case stats["age"]
	when 0..17 then stats["age_group"] = "child"
	when 18..64 then stats["age_group"] = "adult"
	else stats["age_group"] = "senior"
	end
end

p munsters