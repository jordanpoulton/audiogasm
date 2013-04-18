require 'test_helper'
require 'timecop'

class ArtistGigInfoFinderTest < ActiveSupport::TestCase

  def setup
    @artists_gig_info = ArtistGigInfoFinder.new("london", Date.today, Date.today)
  end

  test 'has location when initialized' do
    @artists_gig_info
    assert_equal "london", @artists_gig_info.location
  end

  test 'has min_date when initialized' do
    @artists_gig_info
    assert_equal Date.today, @artists_gig_info.min_date
  end

  test 'has max_date when initialized' do
    @artists_gig_info
    assert_equal Date.today, @artists_gig_info.max_date
  end

  test 'returns no results when no gigs are found in date range and location' do
    ArtistGigInfoFinder.new("Honolulu", "2897-04-02", "2897-04-03")
    assert_equal 0, artists_gig_info.get_artist_gig_info.count
  end

end
