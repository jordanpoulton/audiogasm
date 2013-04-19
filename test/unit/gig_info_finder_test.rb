require 'test_helper'

class GigInfoFinderTest < ActiveSupport::TestCase

  def setup
    @gig_filter = GigInfoFinder.new("london", Date.today, Date.today)
  end

  test 'has a location when initialized' do
    @gig_filter
    assert_equal "london", @gig_filter.location
  end

  test 'has a from date when initialized' do
    @gig_filter
    assert_equal Date.today, @gig_filter.from
  end

  test 'has a to date when initialized' do
    @gig_filter
    assert_equal Date.today, @gig_filter.to
  end

  test 'it returns gig\'s info for specified filters' do
    assert GigInfoFinder.get_gig_info('london', Date.today, Date.today)
  end
end
