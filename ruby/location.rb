#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'solartime'

city, location = ARGV

if location == nil
  city, location = "Helsinki", "KP20LE"
elsif /[A-Ra-r][A-Ra-r][0-9][0-9][A-Xa-x][A-Xa-x]/.match(city)
  city, location = location, city
end

solartime = Solartime.new

solartime.command_line_solartime city, location
