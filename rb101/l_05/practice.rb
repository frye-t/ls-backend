# arr = ['10', '11', '9', '7', '8']

# arr.sort do |a, b|
#   b.to_i <=> a.to_i
# end

# books = [
#   {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
#   {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
#   {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
#   {title: 'Ulysses', author: 'James Joyce', published: '1922'}
# ]

# book.sort_by { |book| book[:published] }

# arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
# arr1[2][1][3]

# arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
# arr2[1][:third][0]

# arr3 = [['abc'], ['def'], {third: ['ghi']}]
# arr3[2][:third][0][0]
# hsh2[:third].key(0)
# hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
# hsh1['b'][1]

# hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
# hsh2[:third].key(0)

# arr1 = [1, [2, 3], 4]
# arr1[1][1] = 4

# arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
# arr2[2] = 4

# hsh1 = {first: [1, 2, [3]]}
# hsh1[:first][2][0] = 4

# hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
# hsh2[['a']][:a][2] = 4

# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# sum = 0
# munsters.each do |_, stats|
#   sum += stats['age'] if stats['gender'] == 'male'
# end
# p sum

# munsters.each do |name, stats|
#   puts "#{name} is a #{stats['age']}-year old #{stats['gender']}"
# end

# a = 2
# b = [5, 8]
# arr = [a, b] # => [2, [5,8]]

# arr[0] += 2 # => [4, [5,8]]
# arr[1][0] -= a # => [4, [3, 8]]

# vowels = 'aeiou'
# hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# hsh.each_value do |values|
#   values.each do |str|
#     str.chars.each do |c|
#       puts c if vowels.include?(c)
#     end
#   end
# end

# arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]
# arr2 = arr.map do |arr|
#   arr.sort { |a,b| b <=> a}
# end
# p arr
# p arr2

## ISSUES ON SOLVING THIS PROBLEM
# arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# new_arr = arr.map do |hsh|
#   inc_hsh = {}
#   hsh.each do |k,v|
#     inc_hsh[k] = v + 1
#   end
#   inc_hsh
# end

# p new_arr

# arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

# new_arr = arr.map do |sub_arr|
#   sub_arr.select { |n| n % 3 == 0 }
# end

# p new_arr

# arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# # expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}
# hsh = {}
# arr.each do |sub_arr|
#   hsh[sub_arr[0]] = sub_arr[1]
# end

# p hsh

# arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]

# new_arr = arr.sort_by do |sub_arr|
#   sub_arr.select do |n|
#     n.odd?
#   end
# end

# p new_arr

# hsh = {
#   'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
#   'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
#   'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
#   'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
#   'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
# }


# new_arr = hsh.map do |name, stats|
#   if stats[:type] == 'fruit'
#     stats[:colors].map do |color|
#       color.capitalize
#     end
#   elsif stats[:type] == 'vegetable'
#     stats[:size].upcase
#   end
# end

# p new_arr

# arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# new_arr = arr.select do |outer_hsh|
#   outer_hsh.all? do |_, value|
#     value.all? do |num|
#       num.even?
#     end
#   end
# end

# p new_arr

HEX = [*('0'..'9')] + [*('a'..'f')]

def rand_hex_string(length)
  str = ''
  length.times do 
    str << HEX[rand(HEX.length-1)]
  end
  str
end

def get_uuid(pattern=[8,4,4,4,12])
  uuid = []
  pattern.each do |num|
    uuid << rand_hex_string(num)
  end
  uuid.join('-')
end

p get_uuid
