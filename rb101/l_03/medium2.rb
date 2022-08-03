=begin

# Q1
a = "forty two"
b = "forty two"
c = a

puts a.object_id
puts b.object_id
puts c.object_id

# Q2

a = 42
b = 42
c = a

puts a.object_id
puts b.object_id
puts c.object_id

# Q3

def tricky_method(a_string_param, an_array_param)
  p an_array_param.object_id
  p a_string_param.object_id
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
  p an_array_param.object_id
  p a_string_param.object_id
end

my_string = "pumpkins"
my_array = ["pumpkins"]
p my_array.object_id
p my_string.object_id
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# Q4

def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# Q5

def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param = ["pumpkins", "rutabaga"]
  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
=end 
# Q6

def color_valid(color)
  color == "blue" || color == "green"
end

p color_valid("red")
p color_valid("green")
p color_valid("blue")
