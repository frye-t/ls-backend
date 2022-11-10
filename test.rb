require 'date'

class MyNum
  def initialize(num=2)
    @num = num
  end

  def output
    puts @num
  end

  def p_num(num)
    p num
  end

  def self.class_p_num(num)
    p num
  end

  def p_num_ivar(num)
    puts "ivar: #{@num} || arg: #{num}"
  end

  def is_num?(num)
    num.is_a?(Integer)
  end

  def check_all_are_num
    nums = [6, 7, 8, 9, 10]
    is_num_proc = method(:is_num?).to_proc
    nums.map(&is_num_proc)
  end

  def day?
    (@day_of_week + "?").to_sym
  end

  def string_to_sym_to_call_variable_method(day_of_week)
    @day_of_week = day_of_week
    date = Date.civil(2022, 1, 1)
    all_dates = []
    10.times do
      all_dates << date
      date = date.next_day
    end
    a = all_dates.map(&day?)
    b = all_dates.map(&:sunday?)
    [a, b]
  end
end

def p_arg_from_main(arg)
  p arg
end

puts "--------------------------------------"
puts "::MyNum Objects we will be working with::"
puts "--------------------------------------"
a = Array.new(5) { |n| MyNum.new((n+1)*2) }
pp a
puts "--------------------------------------"

# When we pass &:output as an argument to a method that yields to a block,
# the interpreter converts that to a block that reads
# { |n| n.output } - in turn, calling MyNum#output on each item, and prints it
puts "::Basic Symbol > Proc > Block conversion::"
puts "--------------------------------------"
a.each(&:output) # => 2 4 6 8 10 each on a new line
puts "--------------------------------------"

# This cannot be used with methods that have defined parameters
# For example...

# a.each(&:p_num) # => ArgumentError

# This method does exist within the scope of a MyNum object and is a part of 
# the public interface, so we are allowed to call this method, however, it 
# requires an argument, which we cannot pass this way

# One would hope that this method call would pass each item in the collection to
# #p_arg, but as we know, it simply tries to invoke #p_arg() on each item 

# To allow for this type of behavior, to invoke a method multiple times with
# each item in the collection as an argument, rather than as the calling 
# object, we must pass the method name as a symbol to Object#method to create
# a new Method object, and then call Method#to_proc on it. 

# Apparently, this creates a new lambda that takes each item in the collection
# as a block parameter (argument) rather than calling the method on that object
# <Proc:0x0000564108f37588 (lambda)> 
puts "::Passing arguments instead of invoking on (main)::"
puts "--------------------------------------"
puts_arg_proc = method(:p_arg_from_main).to_proc
a.each(&puts_arg_proc) # => calls puts on each MyNum Object
puts "--------------------------------------"

# Since the #method invocation above call is Object#method, as per the 
# Method documentation, that lead me to explore `main` a little further.

puts "::main Exploration::"
puts "--------------------------------------"
p self # => main
p self.class # => Object
self.p_arg_from_main("hello") # => "hello"
# Whenever we call a method from within main, Ruby interprets the
# implicit receiver, an instance of Class Object that is 'main'
puts "--------------------------------------"

# This implies that we should be able to call #method on a custom object
# in order to extract a method that has defined parameters from within
# that object 

puts "::Passing arguments instead of invoking on (MyNum.new)::"
puts "--------------------------------------"
p_num_from_mynum_proc = MyNum.new.method(:p_num).to_proc
a.each(&p_num_from_mynum_proc) # => calls puts on each MyNum Object

["an", "array", "of", "words"].each(&p_num_from_mynum_proc)
# => passes each element of the array as an argument

[1, 2, 3, 4, 5].each(&p_num_from_mynum_proc)
# => passes each element of the array as an argument
puts "--------------------------------------"

# Not only do we extract the behavior of this method, we are now able to 
# invoke this method completely separately from MyNum objects and pass
# anything we want to it, as long as the type passed in will not throw
# an error based on the behavior inside the method definied within MyNum,
# this code will run.

# Note how we created a new instance of MyNum to retreive the method in the
# previous example, if we create a Class Method inside MyNum that we want
# to extract, we can do so without instantiating a new MyNum object

puts "::Passing arguments, extracted from Class instead of Instance (MyNum)::"
puts "--------------------------------------"
class_p_num_from_mynum_proc = MyNum.method(:class_p_num).to_proc
a.each(&class_p_num_from_mynum_proc) 
["an", "array", "of", "words"].each(&class_p_num_from_mynum_proc)
[1, 2, 3, 4, 5].each(&class_p_num_from_mynum_proc)
puts "--------------------------------------"

# Similar to our previous example, all of these run and output each element
# of the calling Array

# One thing to keep note of here is Binding. Even though we can call this 
# method on completely different types of objects, the Proc still retains
# its binding from the Custom Objet from which it was extracted

puts "::Extracted Procs retain Binding from Instance regardless of arguments::"
puts "--------------------------------------"
p_num_ivar_from_mynum_proc = MyNum.new.method(:p_num_ivar).to_proc
[1, 2, 3, 4, 5].each(&p_num_ivar_from_mynum_proc) # => ie "ivar: 2 || arg: 3"
puts "--------------------------------------"

# Just as with Objec#method, if we call #method from within a custom class, 
# Ruby will interpret an implicit receiver as the current instance of our
# class. This means that we can essentially create shortcuts within our classes
# to call a method Array#size number of times, passing in each element of the
# Array as an argument. 

puts "::Using CustomObject#method to extract method with definied parameters::"
puts "--------------------------------------"
p MyNum.new.check_all_are_num
puts "--------------------------------------"

# We can use the ability of unary & to convert a method to a proc and use it
# from within our Custom Classes. Within the method below, we create an
# Array of 10 dates and then call MyNum#day? on each of the Date objects in
# that arary. MyNum#day? takes the instance variable, defined by the argument
# passed in to this method call, to create a symbol (in this case :sunday?).
# The return value from MyNum#day? in this case is :sunday?, which is then
# converted to the block { |date| date.sunday? }, and yielded to as we iterate
# over each element in our Array of Dates.
puts "::Unary& to convert Symbol >> Block inside Custom Class::"
puts "::Also highlights how we can change the method called at runtime::"
puts "--------------------------------------"
pp MyNum.new.string_to_sym_to_call_variable_method('sunday')
puts "--------------------------------------"



# Summary::
# All of these reference converting a symbol to a proc, then converting
# that proc to a block and passing it to our yielding method invocation.

# If we want to use collection.method_that_yield(&:method_name)
# #method_name must exist within the public interface of the Objects that
# are contained within the Collection. When we convert that method to a block
# using &, it will be invoked on our collection object.
#
# collection.method_that_yields(&:method_name)
# { |coll_item| coll_item.method_name }
#
# If what comes after & is a method call, Ruby will attempt to convert
# the return value of that method to a Proc by #to_proc. If that return value
# is a symbol, Ruby will interpret it as above. Similarly, if what comes after
# Unary& is anything other than a Proc, Ruby will attempt to invoke #to_proc.
# If successful, that Proc will be converted to a Block and passed to our 
# yielding method.
#
# Note: This use of Procs cannot be used on Methods that have defined 
# parameters as an ArgumentError will be thrown.

# If we want to pass all items in a Collection as arguments to a method,
# rather than invoking that method on an object, we must invoke Object#method
# to create a Method object and then convert that object to a Proc. When using
# #method without an explicit receiver, implicit self will be used. Once
# We have this Proc object, we can pass it to a yielding method using
# Unary& to convert it to a block
# !!method() is not a place holder!!
#
# method_proc = method(:method_name).to_proc
# collection.method_that_yields(&method_proc)
# { |coll_item| method_name(coll_item) }
#
# When extracting a method from within a CustomClass by using 
# ClassName.new.method(:method_name).to_proc
# or ClassName.method(:method_name).to_proc
# The binding for that instance or class is retained by the proc.
#
# By creating a Method Object from our Symbol, and then calling #to_proc
# on this Object, a Lambda is formed instead of a standard Proc.
# p method(:method_name).to_proc # => Proc (lambda)
#
# When using Procs and Lambdas in this fashion, by converting
# them to Blocks using Unary&, each is converted to a Block differently.
# { |coll_item| coll_item.method_name } < &Proc
# { |coll_item| method_name(coll_item) } < &Lambda

