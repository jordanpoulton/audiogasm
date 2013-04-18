require 'test_helper'

class ArtistGigInfoFinderTest < ActiveSupport::TestCase

  test 'has location when initialized' do
    finder = ArtistGigInfoFinder.new("london", Date.today)
    assert_equal "london", finder.location
  end

  test 'has min_date when initialized' do
    finder = ArtistGigInfoFinder.new("london", Date.today)
    assert_equal Date.today, finder.min_date
  end

   test 'exception when min_date not a date when initialized' do
    assert_raise { finder = ArtistGigInfoFinder.new("london", "not a date") }
  end


#   test 'can return '
end
