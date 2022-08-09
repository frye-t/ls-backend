def prompt(msg)
	puts "==> #{msg}"
end

nums = []
prompt("Enter the 1st number: ")
nums << gets.chomp.to_i

prompt("Enter the 2nd number: ")
nums << gets.chomp.to_i

prompt("Enter the 3rd number: ")
nums << gets.chomp.to_i

prompt("Enter the 4th number: ")
nums << gets.chomp.to_i

prompt("Enter the 5th number: ")
nums << gets.chomp.to_i

prompt("Enter the last number: ")
search_num = gets.chomp.to_i

if nums.include?(search_num)
	puts "The number #{search_num} appears in #{nums}"
else
	puts "The number #{search_num} does not appear in #{nums}"
end