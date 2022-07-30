# ask user for 2 numbers
# ask user for operation
# perform requested operation on both numbers
# output result

Kernel.puts("Welcome to Calculator!")

Kernel.puts("What's the first number?")
num_1 = Kernel.gets().chomp().to_i()

Kernel.puts("What's the second number?")
num_2 = Kernel.gets().chomp().to_i()

Kernel.puts("What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide")
operator = Kernel.gets().chomp()

result = if operator == '1'
    num_1 + num_2
  elsif operator == '2'
    num_1 - num_2
  elsif operator == '3'
    num_1 * num_2
  elsif operator == '4'
    num_1.to_f / num_2.to_f
  else
    Kernel.puts("Invalid Input")
end

Kernel.puts("The result is #{result}")