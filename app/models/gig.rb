class Gig

  attr_reader :songkick_artist_id, :location, :date, :venue, :ticket_link

  def initialize(songkick_artist_id, location, date, venue, ticket_link)
    @songkick_artist_id = songkick_artist_id
    @location = location
    @date = date
    @venue = venue
    @ticket_link = ticket_link
  end

end

  # http = Curl.get("http://api.songkick.com/api/3.0/events.json?location=sk:24426&min_date=2013-04-18&max_date=2013-04-19&page=1&per_page=10&apikey=Hkockg21oUnNQEZa")
  # JSON.parse(http.body_str)["resultsPage"]["results"]["event"][0]["venue"]["displayName"]
  # Gets the venue name