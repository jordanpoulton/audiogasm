class ArtistFilterInfoProvider

  ECHONEST_API_KEY = ENV['ECHONEST_API_KEY']


  def self.get_artist_genres(artist_id)
    http = Curl.get("http://developer.echonest.com/api/v4/artist/terms?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{artist_id}&format=json")
    json_hash = JSON.parse(http.body_str)
    if json_hash["response"]["status"]["message"] == "Success"
      json_hash['response']['terms'].map{|e| e["name"] }
    else
      return "Couldn't find artist"
    end
  end

  def self.check_artist_is_of_genre(artist_id, genre)
    artist_genres = get_artist_genres(artist_id)
    artist_genres.detect { |item| return true if item == genre}
    false
  end
end