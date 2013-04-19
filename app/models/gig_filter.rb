class GigFilter

  def self.should_artist_be_played?(artist_id, genres)
    genres.detect do |item|
      ArtistFilterInfoProvider.check_artist_is_of_genre(artist_id, item)
    end
  end
end
