class MainController < ApplicationController


  def home
  end

  def playlist_page
    @where = params[:where]
    @min_date = params[:min_date]
    @max_date = params[:max_date]
    @what = params[:genre]
  end

  def self.get_artist_id_from_form(where, min_date, max_date, what)
    artist_array = SongKickApi.get_upcoming_artists_by_date_and_location(where, min_date, max_date)
    artist_array.map do |artist|
      what.map do |genre|
      EchonestApi.check_artist_is_of_genre(artist, genre)
      end
    end
  end
end
