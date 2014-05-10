task :rspecs do
  sh "rspec ruby"
  puts "RSpec tests have been run."
end

task :tests => [:rspecs] do
  puts "Tests have been run."
end

task :default => [:tests] do
  puts "Starting web server now. Exit with Ctrl + C."
  sh "ruby ruby/webserver.rb"
end
