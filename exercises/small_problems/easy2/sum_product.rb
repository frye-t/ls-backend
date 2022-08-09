OPERATIONS = %w(s p)

def prompt(msg)
  puts ">> #{msg}"
end

def valid_int?(num)
  num.to_i.to_s == num && num.to_i > 0
end

def display_sum_or_product(num, op)
  total = 0
  op_text = ''

  if op.start_with?('s')
    total = 1.upto(num).inject(:+)
    op_text = 'sum'
  elsif op.start_with?('p')
    total = 1.upto(num).inject(:*)
    op_text = 'product'
  end

  puts "The #{op_text} of the integers between 1 and #{num} is #{total}."
end

num = ''
loop do
  prompt('Please enter an integer greater than 0: ')
  num = gets.chomp

  break if valid_int?(num)
  prompt('Invalid input.')
end

num = num.to_i

operation = ''
loop do
  prompt("Enter 's' to compute the sum, 'p' to compute the product.")
  operation = gets.chomp

  break if operation.start_with?(*OPERATIONS)
  prompt("Invalid input. Use 's' or 'p' only.")
end

display_sum_or_product(num, operation)
