def word_sizes(str)
  final_counts = {}
  word_sizes = str.split.map(&:size)
  unique_sizes = word_sizes.uniq

  for size in unique_sizes
    final_counts[size] = word_sizes.count(size)
  end

  final_counts
end


p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
p word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
p word_sizes('') == {}
