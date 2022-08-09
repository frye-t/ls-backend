def running_total(ary)
  running_total_ary = []
  current_total = 0

  ary.each do |n|
    current_total += n
    running_total_ary << current_total
  end

  running_total_ary
end

p running_total([2, 5, 13]) == [2, 7, 20]
p running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
p running_total([3]) == [3]
p running_total([]) == []
