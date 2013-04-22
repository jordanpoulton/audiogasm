require 'test_helper'

class ArtistFilterInfoProviderTest < ActiveSupport::TestCase

  ECHONEST_API_KEY = ENV['ECHONEST_API_KEY']

  def setup
    VCR.insert_cassette name
    @radiohead_id = '253846'
    @radiohead_genres = ["rock", "alternative rock", "electronic", "alternative", "pop", "art rock", "90s", "electronica", "experimental", "modern rock", "post-punk", "jazz", "british pop", "experimental rock", "ambient", "british rock", "alternative pop rock", "indietronica", "grunge", "progressive rock", "80s", "indie", "soundtrack"]
    @invalid_artist = '1678900767865788'
    @user_genre_1 = "rock"
    @user_genre_2 = "jjjj"
    @artist_genres = []
  end

  def teardown
    VCR.eject_cassette
  end

  test "can get a list of artist's genres" do
    response = ArtistFilterInfoProvider.get_artist_genres(@radiohead_id)
    assert_includes response, "rock"
    assert_equal @radiohead_genres, response
  end

  test "return true Artist's genres match user requested genres" do
    assert ArtistFilterInfoProvider.check_artist_is_of_genre(@radiohead_id, @user_genre_1)
  end

  test "returns false if artist does not match genre" do
    refute ArtistFilterInfoProvider.check_artist_is_of_genre(@radiohead_id, @user_genre_2)
  end

  test "returns 'couldn't find artist' if artist if unrecognised" do
    assert_equal ArtistFilterInfoProvider.get_artist_genres(@invalid_artist), "Couldn't find artist"
  end

end

