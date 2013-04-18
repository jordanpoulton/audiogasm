# require 'timecop'
require "test_helper"

class ArtistGigInfoFinderTest < ActiveSupport::TestCase

  def setup
    # Timecop
    @gigs = ArtistGigInfoFinder.new("london", Date.today, Date.today)
  end

  test 'has location when initialized' do
    @gigs
    assert_equal "london", @gigs.location
  end

  test 'has min_date when initialized' do
    @gigs
    assert_equal Date.today, @gigs.min_date
  end

  test 'has max_date when initialized' do
    @gigs
    assert_equal Date.today, @gigs.max_date
  end

  # describe 'xxx' do

  #   before do
  #     Timecop.freeze(Date.local(2000, 1, 1))
  #   end

  #   after do
  #     Timecop.return
  #   end

  test 'returns no results when no gigs are found in date range and location' do
    ArtistGigInfoFinder.new("Honolulu", "2897-04-02", "2897-04-03")

    @gigs.get_gigs_info.count
  end
end
