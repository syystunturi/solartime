task :rspecs do
  sh "rspec ruby/spec/maidenhead_spec.rb"
  puts "RSpec tests have been run."
end

task :tests => [:rspecs] do
  puts "Tests have been run."
end

task :default => [:tests] do
  puts "Starting web server now. Exit with Ctrl + C."
  sh "ruby ruby/webserver.rb"
end
