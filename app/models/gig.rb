class Gig

  attr_reader :artist_id, :location, :date, :venue, :ticket_link

  def initialize(artist_id, location, date, venue, ticket_link)
    @artist_id = artist_id
    @location = location
    @date = date
    @venue = venue
    @ticket_link = ticket_link
  end

  def song
    artist = @artist_id.shuffle.first
    SongProvider.get_track_embed_url(artist)
  end

  def self.find(location, from, to, genre, n = 1)
    gigs = GigInfoProvider.new(location, from, to).get_upcoming_gigs
    get_nth_valid_gig(gigs, genre, n)
  end

  def self.get_nth_valid_gig(gigs, genre, n)
    gigs.detect {|gig| repetition = 0
    while repetition < n
      if gig.check_gig_is_valid(genre)
        false
      elsif !gig.check_gig_is_valid(genre)
        false
      else
        return gig.check_gig_is_valid(genre)
      end
      repetition +=1
    end }
  end

  def check_gig_is_valid(genre)
    self.artist_id.any? {|artist| ArtistFilterInfoProvider.is_artist_valid?(artist, genre)}
  end

  # def get_nth_valid_gig(gig, genre, n)
  #   repetition = 0
  #   while repetition < n
  #     if gig.check_gig_is_valid(genre)
  #       return false
  #     elsif !gig.check_gig_is_valid(genre)
  #       return false
  #     else
  #       gig.check_gig_is_valid(genre)
  #     end
  #     repetition +=1
  #   end
  # end
end



