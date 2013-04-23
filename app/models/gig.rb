class Gig

  attr_reader :songkick_artist_id, :location, :date, :venue

  def initialize(songkick_artist_id, location, date, venue)
    @songkick_artist_id = songkick_artist_id
    @location = location
    @date = date
    @venue = venue
  end

  def song
    artist = @songkick_artist_id.shuffle.first
    SongProvider.get_song_from_rdio(artist)
  end

  def self.find(location, from, to, genre)
    gigs = GigInfoProvider.new(location, from, to).get_upcoming_gigs
    gigs.detect {|gig| gig.songkick_artist_id.detect{ |artist| ArtistFilterInfoProvider.check_artist_is_of_genre(artist, genre)}}

    # upcoming_gigs = find_upcoming_gigs
    # filter_by_genre(upcoming_gigs)
  end

end
