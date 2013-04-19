ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # Add more helper methods to be used by all tests here...


  VCR.config do |c|
    c.stub_with :webmock
    c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
    c.default_cassette_options = { :record => :new_episodes }
  end
  
end
