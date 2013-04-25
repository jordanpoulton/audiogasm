class SearchController < ApplicationController

  def show
    @gig = Gig.find(params[:location].downcase, params[:from], params[:to], params[:genre].downcase)
    @genre = params[:genre].downcase
    @song = @gig.song
    @artist = ArtistFilterInfoProvider.get_artist_name(@gig.artist)
  end
end
