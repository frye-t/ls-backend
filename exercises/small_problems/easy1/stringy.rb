def stringy(num, swap=1)
  bin_str = ''
  if swap == 0	
    num.times { |n| bin_str.concat n.even? ? '0' : '1'}
  else
    num.times { |n| bin_str.concat n.even? ? '1' : '0'}
  end

  bin_str
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'