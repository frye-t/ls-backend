def xor?(bool_1, bool_2)
  p "#{bool_1} - #{bool_2}"
  return true if ((bool_1 || bool_2) && !(bool_1 && bool_2))
  return false
end

p xor?(5.even?, 4.even?) == true
p xor?(5.odd?, 4.odd?) == true
p xor?(5.odd?, 4.even?) == false
p xor?(5.even?, 4.odd?) == false