require 'test_helper'

class SearchControllerTest < ActionController::TestCase

  # def setup
  #   @where = 'london'
  #   @min_date = '2013-04-21'
  #   @max_date = '2013-04-22'
  #   @what = 'rock'
  # end

  test 'gets search form' do
    get :new
    assert_response :success
    assert_template 'search/new'
  end

  test 'searches for a song' do

  end
end
