require 'test_helper'

class GigTest < Test::Unit::TestCase

  def setup
    VCR.insert_cassette name
    @location = 'london'
    @from = Date.today
    @to = Date.tomorrow
    @genre = 'rock'
  end

  def teardown
    VCR.eject_cassette
  end

  test 'find gig' do
    gig = Gig.find(@location, @from, @to, @genre)
    assert_equal gig.artist_id, [4309686]
    assert_equal gig.location, "London, UK"
    assert_equal gig.date, "2013-04-22T19:30:00+0000"
    assert_equal gig.venue, "Phoenix Artist Club"
  end

  test 'get song' do


  end

end
