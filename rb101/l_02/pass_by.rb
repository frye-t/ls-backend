def test(b)
  b.map {|letter| "I like the letter: #{letter}"}
  p b.object_id
end

a = ['a', 'b', 'c']
test(a)
p a.object_id
