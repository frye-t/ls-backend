def count_occurrences(vehicles)
  downcase_vehicles = vehicles.map(&:downcase)

  occurences = downcase_vehicles.uniq.each_with_object({}) do |vehicle, hash|
    hash[vehicle] = downcase_vehicles.count(vehicle)
  end

  occurences.each { |k, v| puts "#{k} => #{v}" }
end


vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck', 'suv', 'SuV'
]

count_occurrences(vehicles)


