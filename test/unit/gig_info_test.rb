require 'test_helper'

class GigInfoProviderTest < ActiveSupport::TestCase

  def setup
    @gig_info_request = GigInfo.new('london', '2013-04-25', '2013-04-26' )
    @gig_info_request_invalid = GigInfo.new('jalilililili', '2013-04-25', '2013-04-26')
    @gig_info_request_date_format = GigInfo.new('london', 'Friday, 19 April, 2013', 'Friday, 19 April, 2013')
    VCR.insert_cassette name
  end

  def teardown
    VCR.eject_cassette
  end

  test 'has a location when initialized' do
    @gig_info_request
    assert_equal "london", @gig_info_request.location
  end

  test 'has a from date when initialized' do
    @gig_info_request
    assert_equal '2013-04-25', @gig_info_request.from
  end

  test 'has a to date when initialized' do
    @gig_info_request
    assert_equal '2013-04-26', @gig_info_request.to
  end

  test 'can get an area id for a location' do
    assert_equal 24426, @gig_info_request.get_location_id
  end

  test 'returns readable error message if location not found' do
    assert_raise (RuntimeError) { @gig_info_request_invalid.get_location_id }
  end

  test 'can successfully make a request to songkick event API' do
    assert_not_nil @gig_info_request.api_event_call["resultsPage"]["totalEntries"]
  end

  test 'can get an list of upcoming gigs' do
    assert_instance_of Gig, @gig_info_request.get_upcoming_gigs[0]
  end

  test 'convert params to valid API date format' do
    assert_equal "2013-04-19", GigInfo.format_date('Friday, 19 April, 2013')
  end

  test 'has a from date when initialized with another date input format' do
    assert_equal '2013-04-19', @gig_info_request_date_format.from
  end

end
