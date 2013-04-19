require 'test_helper'

class GigFilterTest < ActiveSupport::TestCase

  def setup
    @radiohead_id = '253846'
    @radiohead_genres = ["rock", "alternative rock", "electronic", "alternative", "pop", "art rock", "90s", "electronica", "experimental", "modern rock", "post-punk", "jazz", "british pop", "experimental rock", "ambient", "british rock", "alternative pop rock", "indietronica", "grunge", "progressive rock", "80s", "indie", "soundtrack"]
    @invalid_artist = '1678900767865788'
    @user_genre_array = ["rock", "jjjj"]
    @user_genre_array_invalid = ['dddd', 'sssss', 'ooooo']
  end

  test "return true if any of artist's genres match user requested genres" do
    assert GigFilter.should_artist_be_played?(@radiohead_id, @user_genre_array)
  end

  test "return false if none of artist's genres match user requested genre" do
    refute GigFilter.should_artist_be_played?(@radiohead_id, @user_genre_array_invalid)
  end

end