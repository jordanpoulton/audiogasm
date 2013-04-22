class SearchController < ApplicationController

  def show
    @gig = Gig.find(params)
    @song = @gig.song
  end
end
