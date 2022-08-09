def greet(name)
  if name[-1] == '!'
    puts "HELLO #{name.upcase.chop}. WHY ARE WE SCREAMING?"
  else
    puts "Hello #{name}."
  end
end

print "What is your name? "
name = gets.chomp
greet(name)