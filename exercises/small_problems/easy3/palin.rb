VALID_CHARS = ('a'..'z').to_a + ('0'..'9').to_a

def palindrome?(str)
  str == str.reverse
end

# def real_palindrome?(str)  
#   mod_str = str.downcase.delete('^a-z0-9')
#   palindrome?(mod_str)
# end


# p real_palindrome?('madam') == true
# p real_palindrome?('Madam') == true           # (case does not matter)
# p real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
# p real_palindrome?('356653') == true
# p real_palindrome?('356a653') == true
# p real_palindrome?('123ab321') == false

def palindromic_number?(num)
  palindrome?(num.to_s)
end

p palindromic_number?(034543) == true
p palindromic_number?(123210) == false
p palindromic_number?(22) == true
p palindromic_number?(5) == true