require 'dotenv/load'
require 'simplecov'

# Start to measure code coverage for our testing suite. I’ve also provided some folders to ignore.
SimpleCov.start 'rails' do
  add_filter 'spec/'
  add_filter '.github/'
  add_filter 'lib/generators/templates/'
  add_filter 'lib/mock_graphql_ai/version'
end

# Load support files from the spec/support directory.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

# We are loading the Rails dummy app using “test” environment.
ENV['RAILS_ENV'] = 'test'

# Load the environment.rb file to boot the dummy app.
require_relative '../spec/host_app/config/environment'

# Set the Rails root
ENV['RAILS_ROOT'] ||= "#{File.dirname(__FILE__)}../../../spec/dummy"

