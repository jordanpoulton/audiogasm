class Gig

  attr_reader :artist_id, :location, :date, :venue

  def initialize(artist_id, location, date, venue)
    @artist_id = artist_id
    @location = location
    @date = date
    @venue = venue
  end

end

  # http = Curl.get("http://api.songkick.com/api/3.0/events.json?location=sk:24426&min_date=2013-04-18&max_date=2013-04-19&page=1&per_page=10&apikey=Hkockg21oUnNQEZa")
  # JSON.parse(http.body_str)["resultsPage"]["results"]["event"][0]["venue"]["displayName"]
  # Gets the venue name