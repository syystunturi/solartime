require 'sinatra'
require 'active_support/time'
require_relative 'solartime'

solartime = Solartime.new
header = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN" "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>Solartime</title>
<link rel="stylesheet" href="/solartime.css" type="text/css" media="screen" />
</head>
<body>
<h2>Solartime</h2>
'

maidenhead = '<form name="input" action="/" method="post">
<div>City: <input type="text" name="city" value="Helsinki" /><br/>
Locator: <input type="text" name="location" value="KP20LE" /><br/>
<input type="submit" value="Calculate" /></div>
</form>
'

footer = '<p><%= DateTime.now.in_time_zone("Helsinki") %></p>
</body>
</html>'

stylesheet = 'body { font-family: sans-serif }
h2 { background-color: #d6eaff; border: 2px solid; color: #3399ff }
p { color: #3399ff }'

get '/solartime.css' do
  stylesheet
end

get '/' do
  header + (erb maidenhead.to_s) + (erb footer)
end

post '/' do
  # matches "POST /?city=Helsinki&location=KP20LE"
  @city = params[:city]
  @location = params[:location]

  sunrise_sunset_result = '<form name="input" action="/" method="post">
<div>City: <input type="text" name="city" value="<%= @city %>" /><br/>
Locator: <input type="text" name="location" value="<%= @location %>" /><br/>
<input type="submit" value="Calculate" /></div>
</form>'

  longitude, latitude = solartime.web_server_solartime @city, @location unless @city.nil?

  west_or_east = if longitude > 0
                   'E'
                 else
                   'W'
                 end

  south_or_north = if latitude > 0
                     'N'
                   else
                     'S'
                   end

  longitude_full = longitude.to_i.abs
  longitude_minutes = 60 * (longitude.abs - longitude_full)
  latitude_full = latitude.to_i.abs
  latitude_minutes = 60 * (latitude.abs - latitude_full)

  sunrise_sunset_result += "<h2><%= @city %> (<%= @location %>)</h2>
<div><ul>
  <li>Longitude: #{west_or_east} #{longitude_full}&deg; #{'%.3f' % longitude_minutes}</li>
  <li>Latitude: #{south_or_north} #{latitude_full}&deg; #{'%.3f' % latitude_minutes}</li>
</ul></div>"

  header + (erb sunrise_sunset_result) + (erb footer)
end
