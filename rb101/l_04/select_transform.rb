# def select_fruit(produce)
#   keys = produce.keys
#   counter = 0
#   fruits = {}

#   loop do    
#     curr_key = keys[counter]
#     curr_value = produce[curr_key]

#     if curr_value == 'Fruit'
#       fruits[curr_key] = curr_value
#     end

#     counter += 1
#     break if counter == keys.size
#   end

#   fruits
# end

# produce = {
#   'apple' => 'Fruit',
#   'carrot' => 'Vegetable',
#   'pear' => 'Fruit',
#   'broccoli' => 'Vegetable'
# }

# p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}

# def multiply(numbers,multiplier) 
#   multiplied_numbers = []
#   counter = 0

#   loop do
#     break if counter == numbers.size

#     multiplied_numbers << numbers[counter] * multiplier
#     counter += 1
#   end

#   multiplied_numbers
# end

# my_numbers = [1, 4, 3, 7, 2, 6]
# p multiply(my_numbers, 4) # => [3, 12, 9, 21, 6, 18]

odd, even = [1,2,3].partition do |num|
  num.odd?
end
p odd
p even