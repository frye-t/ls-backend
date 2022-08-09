def multiply(n1, n2)
  n1 * n2
end

def power_to_n(base, exp)
  result = 1

  (exp.abs).times { result = multiply(result, base) }

  result = 1 / result.to_f if exp < 0
  result
end

p power_to_n(2, 8) == 256 # true
p power_to_n(-5, 3) == -125 # true
p power_to_n(18, 4) == 104976 # true
p power_to_n(15, 0) == 1 # true
p power_to_n(0, 5) == 0 # true
p power_to_n(5, -2) == 0.04 # true
p power_to_n(0.5, 5) == 0.03125 # true