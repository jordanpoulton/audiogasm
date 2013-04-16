class SongKickApi

  API_KEY = 'Hkockg21oUnNQEZa'

  def self.area_id_for_location(location, country = uk)
    http = Curl.get("http://api.songkick.com/api/3.0/search/locations.json?query=#{location}%20#{country}&apikey=#{API_KEY}")
    JSON.parse(http.body_str)["resultsPage"]["results"]["location"][0]["metroArea"]["id"]
  end

end
