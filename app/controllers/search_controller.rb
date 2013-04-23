class SearchController < ApplicationController

  def show
    @gig = Gig.find(params[:location], params[:from], params[:to], params[:genre].downcase)
    @song = @gig.song
  end
end
