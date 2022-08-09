print "Please write a word or multiple words: "
str = gets.chomp
mod_str = str.delete(' ')
puts "There are #{mod_str.size} characters in \"#{str}\"."
