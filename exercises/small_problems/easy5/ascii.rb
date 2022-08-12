def ascii_value(str)
  str.empty? ? 0 : str.chars.map(&:ord).inject(:+)
end

## Further Exploration: char.ord.chr == char 
#  with a longer string, only returns the first character
#  i.e. 'Four score'.ord.chr returns 'F'

p ascii_value('Four score') == 984
p ascii_value('Launch School') == 1251
p ascii_value('a') == 97
p ascii_value('') == 0
