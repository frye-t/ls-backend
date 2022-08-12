def swap_first_last_char(w)
  w[0], w[-1] = w[-1], w[0]
  w
end

def swap(str)
  words = str.split
  swapped_words = words.map do |word|
    swap_first_last_char(word)
  end
  swapped_words.join(' ')
end

p swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
p swap('Abcde') == 'ebcdA'
p swap('a') == 'a'