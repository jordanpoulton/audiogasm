require 'test_helper'

class SongKickApiTest < ActiveSupport::TestCase

  test 'can get metro area id for london' do
    assert_equal 24426, SongKickApi.area_id_for_location("London")
  end
end
