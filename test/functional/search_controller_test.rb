require 'test_helper'

class SearchControllerTest < ActionController::TestCase

  def setup
    #   @where = 'london'
    #   @min_date = '2013-04-21'
    #   @max_date = '2013-04-22'
    # @what = 'rock'
    VCR.insert_cassette name
  end

  def teardown
    VCR.eject_cassette
  end

  test 'gets search form' do
    get :new
    assert_response :success
    assert_template 'search/new'
  end

  # test 'can search for a song' do
  #   get :show, :location => 'london', :from => '2013-04-21', :to => '2013-04-21', :what => 'rock'
  #   assert_template 'search/show'
  #   assert_equal assigns(:gig), 'foo'
  #   # assert assigns @song
  # end


  test 'validates the correct data when searching for a song' do

  end
end
