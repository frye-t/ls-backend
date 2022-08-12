=begin
What is PEDAC?
- disciplined, structural approach to solving programming problems 
- First process the problem (PEDA), then code with intent (C)

Benefits:
- Will save us time in the long run
- Will help us avoid issues that often arise when we encounter a problem and try and jump straight to coding (i.e. hack and slash coding)
- Failure to meet requirements of the problem 
- Failure to handle edge cases appropriately
- Resulting solution is hard to read or maintain

Tips:
- Getting stuck is normal
- Make mistakes, learn from the mistakes, continue practicing
- Remember: PEDAC should help you. Find a way to make it work for you.
=end

=begin
Common Mistakes
- Not enough time spent parsing the problem
- Fuzzy algorithm
- Lack of flexibility
- Lack of syntax fluency
=end

=begin
Write a method that takes an array of consecutive letters as input and returns the missing letter.
=end

# p determine_missing_letter(['a','b','c','d','f']) == 'e' 
# p determine_missing_letter(['O','Q','R','S']) == 'P'
# p determine_missing_letter(["a","b","c","d","f"]) == "e"
# p determine_missing_letter(["O","Q","R","S"]) == "P"

=begin
# -------------------------------------- Problem ----------------------------
- Input is array of strings
- Ouput is also a string
  - Output is string missing from array of strings

Rules:
- Implicit: case sensitive
  - Missing char is always in the middle

Scratch:
- Single vs double quotations don't seem to matter

# -------------------------------------- Examples ----------------------------
['a','b','c','d','f'] == 'e'
['a','b','c','d','e','f']
ALPHABET = [*('a'..'z')]

# -------------------------------------- Data Structures ----------------------------
Define a method 
Array of strings with alphabet as a CONSTANT


# -------------------------------------- Algorithm -------------------------
- Create array of strings with alphabet as a CONSTANT
  - Use splat operator 
    - To use as a reference point to find the missing letter

- Create a boolean switch to 'remember' if input is upper/lower case
- Find index of first letter in input, in reference array
  - use index.(input_array.first)
    - Iterate through input & alphabet array simultaneously
      - Use found index as counter offset for alphabet array
      - input[0] == ALPHA[0+offset] should be true

- Iterate through both arrays until an element does not match
  - Always compare downcase version from input array
  - Return that element from the alpha array
    - Return upcase if the given array chars are upcase
=end

def determine_missing_letter(arr)
  alpha = [*('a'..'z')]

  is_downcase = true
  is_downcase = false if arr[0].downcase != arr[0]

  idx_offset = alpha.index(arr[0].downcase)

  missing_char = ''
  arr.each_with_index do |char, idx|
    if alpha[idx + idx_offset] != char.downcase
      missing_char = alpha[idx + idx_offset]
      break
    end
  end

  is_downcase ? missing_char : missing_char.upcase
end

p determine_missing_letter(['a','b','c','d','f']) == 'e' 
p determine_missing_letter(['O','Q','R','S']) == 'P'
p determine_missing_letter(["a","b","c","d","f"]) == "e"
p determine_missing_letter(["O","Q","R","S"]) == "P"

=begin
I have interviewed five software engineering candidates over the past two weeks, including folks with grad degrees in computer science/ex-FAANG with 7+ years of experience. 
All five were jointly rejected by myself and a co-interviewer either because the candidates jumped straight into implementation and ended up with bugs during testing or unhandled edge cases, 
and/or their oral-written communication was poor.

So, for those folks who are 'PEDACing' for the first few times:
1) Train your problem solving muscles to start with PEDAC by default (or some equivalent thereof);
2) Get comfortable talking through problems out loud, not just typing silently.

Can't stress enough that PEDAC isn't an arbitrary heuristic meant for getting through the curriculum or 109/129 oral assessments. PEDAC works, especially under pressure.

- Sam Swire (Check)
=end

