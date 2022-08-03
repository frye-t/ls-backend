def reverse_words(str)
	new_str = ''
	str.split.each do |word|
		if word.size >= 5
			new_str << word.chars.reverse.join('') + " "
		else
			new_str << word + " "
		end 
	end
	new_str
end

puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS