.each |num|
	- executes block for all elements

.select |num|
	- returns new collection that matches criteria within block (truthiness)

.map |num|
	- returns new collection based on return value of block

.any? |num|
	- returns boolean based on return value of block (truthiness)
	- will return true if ANY blocks return truthy

.all? |num|
	- same as any, but all return values must be truthy

.each_with_index |num, index|
	- identical to each, but adds index argument for each iteration

.each_with_object |num, array| - |(key, value), collection|
	- identical to each, but adds a collection argument that can be used throughout

.first
	- returns first object in collection
	- option argument to get more than just the first, .first(2)

.include?
	- returns boolean if argument exists in collection

.partition
	- same as select, but adds additional nested array for non-selected items
	- parallel assignment
		odd, even = [1, 2, 3].partition do |num|
			num.odd?
		end

		odd  # => [1, 3]
		even # => [2]
