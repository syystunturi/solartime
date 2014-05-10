require 'sinatra'
require_relative 'solartime'

  solartime = Solartime.new
  header = '<html>
<head>
<link rel="stylesheet" href="solartime.css" type="text/css" />
<title>Solartime</title>
</head>
<body>
<h2>Solartime</h2>'

  maidenhead = '<form name="input" action="/" method="post">
City: <input type="text" name="city" value="Helsinki"><br>
Locator: <input type="text" name="location" value="KP20LE"><br>
<input type="submit" value="Calculate">
</form>'

  footer = "<p><%= Time.now %></p>
</body>
</html>"

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
City: <input type="text" name="city" value="<%= @city %>"><br>
Locator: <input type="text" name="location" value="<%= @location %>"><br>
<input type="submit" value="Calculate">
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
<ul>
  <li>Longitude: #{west_or_east} #{longitude_full}&deg; #{"%.3f" % longitude_minutes}</li>
  <li>Latitude: #{south_or_north} #{latitude_full}&deg; #{"%.3f" % latitude_minutes}</li>
</ul>"
    end

    header + (erb sunrise_sunset_result) + (erb footer)
  end
