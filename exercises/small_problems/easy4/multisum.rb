def multisum(num)
  # multiples = []
  # (1..num).each do |n|
  #   multiples << n if (n % 3 == 0 || n % 5 == 0)
  # end
  # multiples.sum

  (1..num).to_a.select{ |n| n % 3 == 0 || n % 5 == 0 }.inject(:+)
end

p multisum(3) == 3
p multisum(5) == 8
p multisum(10) == 33
p multisum(1000) == 234168