require 'test_helper'
require 'rspec/mocks'

class SearchControllerTest < ActionController::TestCase

  def setup
    RSpec::Mocks.setup(self)
  end

  def teardown
    begin
      RSpec::Mocks.verify
    ensure
      RSpec::Mocks.teardown
    end
  end

  test 'gets search form' do
    get :new
    assert_response :success
    assert_template 'search/new'
  end

  test 'gets search results page' do
    show_search
    assert_response :success
    assert_template 'search/show'
  end

  test 'finds gig from search results' do
    show_search
    assert_equal @gig, assigns(:gig)
  end

  test 'finds song from search results' do
    show_search
    assert_equal 'Lalala', assigns(:song)
  end

  def show_search
    @gig = mock(Gig, song: 'Lalala', location: 'london', date: '2013-04-25', venue: "Jordan's Hut", ticket_link: 'www.blah.com', artist: "Jordan's Barbershop")
    Gig.should_receive(:find).with('london', '2013-04-25', '2013-04-25', 'rock').and_return(@gig)
    get :show, {:location => 'london', :from => '2013-04-25', :to => '2013-04-25', :genre => 'ROCK'}
  end
end
