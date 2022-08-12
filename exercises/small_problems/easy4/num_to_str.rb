DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

def integer_to_string(num)
  str = ''

  loop do
    num, last_digit = num.divmod(10)
    str.prepend(DIGITS[last_digit])
    break if num == 0
  end
  str
end

def signed_integer_to_string(num)
  # num_str = integer_to_string(num.abs)

  # case num <=> 0
  # when -1 then num_str.prepend("-")
  # when +1 then num_str.prepend("+")
  # end

  # num_str

  # [equal, left>, <right]
  sign = ['', '+', '-'][num <=> 0]
  sign + integer_to_string(num.abs)
end

p signed_integer_to_string(4321) == '+4321'
p signed_integer_to_string(-123) == '-123'
p signed_integer_to_string(0) == '0'