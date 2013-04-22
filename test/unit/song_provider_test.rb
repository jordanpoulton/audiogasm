require 'test_helper'

class SongProviderTest < Test::Unit::TestCase

  def setup
    @songkick_radiohead_id = '253846'
    @invalid_artist_id = '1678900767865788'
    VCR.insert_cassette name
    @song = SongProvider.new
  end

  def teardown
   VCR.eject_cassette
  end

  test 'can get rdio artist id with radiohead songkick id' do
    assert_equal 'r91318', @song.get_rdio_artist_id(@songkick_radiohead_id)
  end

  test 'cannot get rdio artist id with invalid songkick id' do
    assert_raise (RuntimeError){@song.get_rdio_artist_id(@invalid_artist_id)}
  end

  test 'get only the first radiohead song with radiohead rdio id' do
    rdio_radiohead_id = @song.get_rdio_artist_id(@songkick_radiohead_id)
    assert_equal 'https://rd.io/e/QitdJsU/', @song.get_song_from_rdio(rdio_radiohead_id, count =1)
  end
end
