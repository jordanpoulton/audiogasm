# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Audiogasm::Application.initialize!

ECHONEST_API_KEY = ENV['ECHONEST_API_KEY']