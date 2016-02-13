task :rspecs do
  sh 'rspec ruby'
  puts 'RSpec tests have been run.'
end

task :audit do
  sh 'bundle-audit update'
  sh 'bundle-audit check'
end

task tests: [:rspecs, :audit] do
  puts 'Tests have been run.'
end

task default: [:tests] do
  puts 'Starting web server now. Exit with Ctrl + C.'
  sh 'ruby ruby/webserver.rb'
end
