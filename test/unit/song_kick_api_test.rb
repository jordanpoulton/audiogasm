require 'test_helper'

class SongKickApiTest < ActiveSupport::TestCase

  test 'can get metro area id for london' do
    assert_equal 24426, SongKickApi.area_id_for_location("London", "UK")
  end

  test 'can get the id of an artist that is playing in specific metro_area_id and date' do
    array =
    http = Curl.get("http://api.songkick.com/api/3.0/events.json?location=sk:24426&min_date=#{Time.now.strftime('%Y-%m-%d')}&max_date=#{(Time.now+1.week).strftime('%Y-%m-%d')}&apikey=Hkockg21oUnNQEZa")
    assert_match(/((?:\+?|\b)[0-9]{6}\b)/, (JSON.parse(http.body_str)["resultsPage"]["results"]["event"][0]["performance"][0]["artist"]["id"].to_s))
  end

end
