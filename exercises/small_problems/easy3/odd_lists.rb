def get_every_other(ary, odd=true)
  new_ary = ary.select.with_index do |v, idx|
    idx += 1 # adding 1 to the index to make if statement more readable
    if(odd)
      idx.odd?
    else
      idx.even?
    end
  end
  new_ary
end

p get_every_other([2, 3, 4, 5, 6]) == [2, 4, 6]
p get_every_other([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
p get_every_other(['abc', 'def']) == ['abc']
p get_every_other([123]) == [123]
p get_every_other([]) == []

p get_every_other([2, 3, 4, 5, 6], false) == [3, 5]
p get_every_other([1, 2, 3, 4, 5, 6], false) == [2, 4, 6]
p get_every_other(['abc', 'def'], false) == ['def']
p get_every_other([123], false) == []
p get_every_other([], false) == []