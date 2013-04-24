require 'test_helper'

class GigTest < Test::Unit::TestCase

  def setup
    VCR.insert_cassette name
    @location = 'london'
    @from = '2013-04-25'
    @to = '2013-04-25'
    @genre = 'rock'
  end

  def teardown
    VCR.eject_cassette
  end

  test 'find gig' do
    gig = Gig.find(@location, @from, @to, @genre)
    assert_equal gig.artist_id, [4301]
    assert_equal gig.location, "London, UK"
    assert_equal gig.date, "Thursday, 25 April 2013"
    assert_equal gig.venue, "O2 Academy Islington"
  end

  test 'get song' do
    gig = Gig.find(@location, @from, @to, @genre)
    assert_equal "https://rd.io/e/QitDF8qB/", gig.song
  end

  test 'formats date correctly' do
    gig = Gig.find(@location, @from, @to, @genre)
    assert_equal 'Thursday, 25 April 2013', gig.date
  end
end