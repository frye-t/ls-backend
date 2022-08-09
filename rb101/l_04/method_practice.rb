# Q1
=begin
[1, 2, 3].select do |num|
  num > 5
  'hi'
end

=end

#Q2

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

= { a: 'ant', b: 'bear', c: 'cat' }