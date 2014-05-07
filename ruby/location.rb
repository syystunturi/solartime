# encoding: utf-8
require_relative 'solartime'

city, location = ARGV

if location == nil
  city, location = "Helsinki", "KP20LE"
elsif /[A-Z][A-Z][0-9][0-9][A-Z][A-Z]/.match(city)
  city, location = location, city
end

solartime = Solartime.new

solartime.print_location city, location
