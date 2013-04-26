class SearchController < ApplicationController

  def show
    @gig = Gig.find(params[:location].downcase, params[:from], params[:to], params[:genre].downcase)
    render 'search/new', flash: "Couldn't find any artists" and return unless @gig
    @genre = params[:genre].downcase
    @song = @gig.song
    @artist = ArtistFilter.get_artist_name(@gig.artist)
  end
end
