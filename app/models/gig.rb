class Gig

  attr_reader :artist_id, :location, :date, :venue

  def initialize(artist_id, location, date, venue)
    @artist_id = artist_id
    @location = location
    @date = date
    @venue = venue
  end

  def song(artist_id)

  end

  def self.find(location, from, to, genre)
    gigs = GigInfoProvider.new(location, from, to).get_upcoming_gigs
    gigs.detect {|gig| gig.artist_id.detect{ |artist| ArtistFilterInfoProvider.check_artist_is_of_genre(artist, genre)}}

    # upcoming_gigs = find_upcoming_gigs
    # filter_by_genre(upcoming_gigs)
  end

end
