DIGITS = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4, 
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9
}

def string_to_integer(str)
  digits = str.chars.map { |c| DIGITS[c] }

  value = 0
  digits.each do |digit|
    value = value * 10 + digit
  end
  value
end

def string_to_signed_integer(str)
  negative = true if str.start_with?('-')
  str.delete!("+-")

  negative ? -string_to_integer(str) : string_to_integer(str)
end

p string_to_signed_integer('4321') == 4321
p string_to_signed_integer('-570') == -570
p string_to_signed_integer('+100') == 100