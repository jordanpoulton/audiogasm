require 'test_helper'

class GigInfoProviderTest < ActiveSupport::TestCase

  def setup
    @gig_filter = GigInfoProvider.new('london', Date.today, Date.today)
    @gig_filter_invalid = GigInfoProvider.new('jalilililili', Date.today, Date.today)
  end

  test 'has a location when initialized' do
    @gig_filter
    assert_equal "london", @gig_filter.location
  end

  test 'has a from date when initialized' do
    @gig_filter
    assert_equal Date.today, @gig_filter.from
  end

  test 'has a to date when initialized' do
    @gig_filter
    assert_equal Date.today, @gig_filter.to
  end

  test 'can get metro_area_id for london' do
    assert_equal 24426, @gig_filter.get_location_id
  end

  test 'can get an area id for a location' do
    assert_equal @gig_filter.get_location_id, 24426
  end

  test 'returns readable error message if location not found' do
    assert_raise (RuntimeError) { @gig_filter_invalid.get_location_id }
  end


  # test 'can get the id of an artist that is playing in specific metro_area_id and date' do
  #   http = Curl.get("http://api.songkick.com/api/3.0/events.json?location=sk:24426&min_date=#{Time.now.strftime('%Y-%m-%d')}&max_date=#{(Time.now+1.week).strftime('%Y-%m-%d')}&apikey=Hkockg21oUnNQEZa")
  #   assert_match(/((?:\+?|\b)[0-9]{6}\b)/, (JSON.parse(http.body_str)["resultsPage"]["results"]["event"][0]["performance"][0]["artist"]["id"].to_s))
  # end

  # test 'can get an artist_id by location and min/max date' do
  #   GigInfoProvider.get_upcoming_artists_by_date_and_location('London', Time.now.strftime('%Y-%m-%d'), (Time.now+1.week).strftime('%Y-%m-%d'))
  #   assert_match(/((?:\+?|\b)[0-9]{6}\b)/, (JSON.parse(http.body_str)["resultsPage"]["results"]["event"][0]["performance"][0]["artist"]["id"].to_s))
  # end
end
