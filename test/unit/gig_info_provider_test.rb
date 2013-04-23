require 'test_helper'

class GigInfoProviderTest < ActiveSupport::TestCase

  def setup
    @gig_info_request = GigInfoProvider.new('london', '2013-04-25', '2013-04-26' )
    @gig_info_request_invalid = GigInfoProvider.new('jalilililili', '2013-04-25', '2013-04-26')
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
    assert_equal @gig_info_request.get_location_id, 24426
  end

  test 'returns readable error message if location not found' do
    assert_raise (RuntimeError) { @gig_info_request_invalid.get_location_id }
  end

  test 'can successfully make a request to songkick event API' do
    assert_not_nil @gig_info_request.api_event_call["resultsPage"]["totalEntries"]
  end

  test 'can get an list of upcoming gigs' do
    assert_instance_of Gig, @gig_info_request.get_upcoming_gigs[0]
    # assert_equal expected_gigs, @gig_info_request.get_upcoming_gigs
  end

  # def expected_gigs
  #   [Gig.new, Gig.new]
  # end
end
