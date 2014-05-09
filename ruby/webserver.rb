require 'sinatra'
require_relative 'solartime'

  solartime = Solartime.new
  header = "<html>
<head>
<title>Solartime</title>
</head>
<body>
<h2>Solartime</h2>"

  maidenhead = '<form name="input" action="/" method="post">
City: <input type="text" name="city" value="Helsinki"><br>
Locator: <input type="text" name="location" value="KP20LE"><br>
<input type="submit" value="Submit">
</form>'

  footer = "<p><%= Time.now %></p>
</body>
</html>"

  get '/' do
    sunrise_sunset_result = "#{maidenhead}"

    header + (erb sunrise_sunset_result) + (erb footer)
  end

  post '/' do
    # matches "GET /?city=Helsinki&location=KP20LE"
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
      sunrise_sunset_result += "<h2><%= @city %> (<%= @location %>)</h2>
<ul>
  <li>Longitude: #{west_or_east}#{longitude}</li>
  <li>Latitude: #{south_or_north}#{latitude}</li>
</ul>"
    end

    header + (erb sunrise_sunset_result) + (erb footer)
  end
