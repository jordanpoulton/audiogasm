require 'test_helper'


class EchonestApiTest < ActiveSupport::TestCase

  test 'can get array of artist genres from artist_id' do
    array = EchonestApi.get_artist_genres_by_id("ARH6W4X1187B99274F")
    assert_equal(["rock", "alternative rock", "electronic", "alternative", "pop", "art rock", "90s", "electronica", "experimental", "modern rock", "post-punk", "jazz", "british pop", "experimental rock", "ambient", "british rock", "alternative pop rock", "indietronica", "grunge", "progressive rock", "80s", "indie", "soundtrack"], array)
  end

end