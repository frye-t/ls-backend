# arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# arr2 = []
# arr2 = arr.map do |hsh|
#   inc_hash = {}
#   hsh.each do |k, v|
#     inc_hash[k] = v +1
#   end
#   inc_hash
# end

# p arr2

# arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]

# sort_arr = arr.sort_by do |sub_ary|
#   sub_ary.select do |num|
#     num.odd?
#   end
# end

# p sort_arr

# hsh = {
#   'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
#   'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
#   'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
#   'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
#   'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
# }

# arr = hsh.map do |name, values|
#   if values[:type] == 'fruit'
#     values[:colors].map do |color|
#       color.capitalize
#     end
#   elsif values[:type] == 'vegetable'
#     values[:size].upcase
#   end
# end

# p arr

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

arr2 = arr.select do |hsh|
  hsh.all? do |k, v|
    v.all? do |num|
      num.even?
    end
  end
end

p arr2