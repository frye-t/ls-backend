def century(year)
  century = year / 100 + 1
  century -= 1 if year % 100 == 0
  century.to_s + century_suffix(century)
end

def century_suffix(century)
  return 'th' if [11,12,13].include?(century % 100)
  
  last_digit = century % 10
  case last_digit
  when 1 then 'st'
  when 2 then 'nd'
  when 3 then 'rd'
  else 'th'
  end
end

p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201) == '113th'

=begin
Rules:
  11, 12, 13 get 'th'
  if not 11,12,13 and
    ends in 1 gets 'st'
    ends in 2 gets 'nd'
    ends in 3 gets 'rd'
  everything else gets 'th'
=end

# first
# second
# third
# fourth
# fifth
# sixth
# ...
# elventh
# twelveth
# thirteenth
# ...
# twenty first
# twenty second
# twenty third
# twenty fourth
# twenty fifth
# twenty sixth
# ...
# thirty first
# thirty second
# ...