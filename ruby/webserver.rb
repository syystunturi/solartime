require 'sinatra'
require 'active_support/time'
require_relative 'solartime'

  solartime = Solartime.new
  header = '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Solartime</title>
<link rel="stylesheet" type="text/css" href="solartime.css" >
</head>
<body>
<h2>Solartime</h2>'

  maidenhead = '<form name="input" action="/" method="post">
<p>City: <input type="text" name="city" value="Helsinki"></p>
<p>Locator: <input type="text" name="location" value="KP20LE"></p>
<p><input type="submit" value="Calculate"></p>
</form>'

  footer = '<p><%= DateTime.now.in_time_zone("Helsinki") %></p>
</body>
</html>'

  get '/solartime.css' do
    "body { font-family: sans-serif }
h2 { background-color: #d6eaff; border: 2px solid; color: #3399ff }
p { color: #3399ff }"
  end

  get '/' do
    sunrise_sunset_result = "#{maidenhead}"

    header + (erb sunrise_sunset_result) + (erb footer)
  end

  post '/' do
    # matches "POST /?city=Helsinki&location=KP20LE"
    @city = params[:city]
    @location = params[:location]

    sunrise_sunset_result = '<form name="input" action="/" method="post">
<p>City: <input type="text" name="city" value="<%= @city %>"></p>
<p>Locator: <input type="text" name="location" value="<%= @location %>"></p>
<p><input type="submit" value="Calculate"></p>
</form>'

    if @city != nil
      longitude, latitude = solartime.web_server_solartime @city, @location

      if longitude > 0
        west_or_east = 'E'
      else
        west_or_east = 'W'
      end

      if latitude > 0
        south_or_north = 'N'
      else
        south_or_north = 'S'
      end

      longitude_full = longitude.to_i.abs
      longitude_minutes = 60 * (longitude.abs - longitude_full)
      latitude_full = latitude.to_i.abs
      latitude_minutes = 60 * (latitude.abs - latitude_full)

      sunrise_sunset_result += "<h2><%= @city %> (<%= @location %>)</h2>
<div><ul>
  <li>Longitude: #{west_or_east} #{longitude_full}&deg; #{"%.3f" % longitude_minutes}</li>
  <li>Latitude: #{south_or_north} #{latitude_full}&deg; #{"%.3f" % latitude_minutes}</li>
</ul></div>"
    end

    header + (erb sunrise_sunset_result) + (erb footer)
  end
