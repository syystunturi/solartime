city, location = ARGV

location_label = "%s (%s)"

if location == nil
  city, location = "Helsinki", "KP20LE"
elsif /[A-Z][A-Z][0-9][0-9][A-Z][A-Z]/.match(city)
  city, location = location, city
end

puts location_label % [city, location]
