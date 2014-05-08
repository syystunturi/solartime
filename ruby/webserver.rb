require 'sinatra'

  header = "<html>
<head>
<title>Solartime</title>
</head>
<body>
<h2>Solartime</h2>

<p>The Solartime development is in progress. Not much to see in here yet. :)</p>"
  code = "<%= Time.now %>"
  footer = "</p>
</body>
</html>"

  get '/' do
    header + (erb code) + footer
  end
