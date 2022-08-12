['ants', 'arc', 'bat', 'cap', 'cape']
[['a', 'car', 'd'], ['a', 'car', 'd', 3], ['a', 'cat', 'b', 'c'], ['b', 2]]

# Example 3

[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end

Line	Action	Object	Side Effect	Return Value	Is Return Value Used?
1 - method call (map) - outer array - none - New ary [1, 3] - No
1-4 block execution - each sub array - none - arr.first - yes, used by map for transformation
2 method call (first) - each sub array - none - element at index-0 of sub array - used by puts
2 method call (puts) - element at each subary idx 0 - outputs a string rep of integer - nil return - not used
3 method call (first) - each sub array - none - element at idx-0 of subary - yes, used to det return value of block 

# Example 4

Line	Action	Object	Side Effect	Return Value	Is Return Value Used?
1	Variable assignment	[[18, 7], [3, 12]]	None	[[18, 7], [3, 12]]	No
1	method call (each)	[[18, 7], [3, 12]]	None	[[18, 7], [3, 12]]	Yes, as variable assignment to my_arr
1-7	outer block execution	Each sub-array	None	Each sub-array	No
2	method call (each)	Each sub array	None	Callin object, sub array we're iterating 	Yes, determine return value of outer block
2-6	inner block execution	Each element of sub ary iterating over	None	nil	no
3	comparison	element of sub ary iterating over	None	boolean	yes, used by if to determine code pathing
4	puts	element of sub ary iterating over	outputs string rep of int	nil	yes, used to determine the return value of the if statement

# Example 5

Line	Action	Object	Side Effect	Return Value	Is Return Value Used?
1	method call (map)	Nested Ary [[1, 2], [3, 4]]	None	new ary [[2, 4], [6, 8]] 	no
1-5	outer block execution	Each sub array	none	new transformed ary	yes, used by top level map transformation
2	method call (map)	each sub array	none	transformed sub arys	yes, used to determine outer block's return value
2-4	inner block execution	each element in subary	none	element iterating over times 2	yes, used by inner map for transformation
3	method call (*)	element we're currently iterating over	none	element * 2	yes, to determine inner block's return value*

# Example 6

Line	Action	Object	Side Effect	Return Value	Is Return Value Used?
1	method call (select)	Nested Hash	none	New ary [{ :c => "cat" }]	no
1-5	outer block execution	each sub-hash	noen	each sub-haash if condition is met	no
2	method call (all?)	each sub-hash	none	the calling object (hash)	yes, to determine return value of outer block
2-4	inner block execution	each k/v pair in subhash	none	boolean	no
3	equal comparison	first letter of each Value	none	boolean	yes, to determine return value of the .all? method call

# Example 9

[[[1], [2], [3], [4]], 
	[['a'], ['b'], ['c']]]