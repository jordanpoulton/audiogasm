class ArtistFilter

  ECHONEST_API_KEY = ENV['ECHONEST_API_KEY']

  def self.get_artist_genres(artist_id)
    genres_from(
      terms_in(
    parsed_api_call(artist_id)))
  rescue
    "Couldn't get artist genres"
  end

  def self.get_artist_name(artist_id)
    http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{artist_id}&format=json")
    json_hash = JSON.parse(http.body_str)
    if json_hash["response"]["status"]["message"] == "Success"
      json_hash['response']['artist']['name']
    else
      "Couldn't get artist name"
    end
  end

  private

  def self.is_artist_valid?(artist_id, genre)
    puts "Checking validity of #{ArtistFilter.get_artist_name(artist_id)}"
    artist_genres = get_artist_genres(artist_id)
    artist_genres.include?(genre)
  rescue
    "We were unable to check artist validity"
  end

  def self.parsed_api_call(artist_id)
    JSON.parse(Curl.get("http://developer.echonest.com/api/v4/artist/terms?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{artist_id}&format=json").body_str)
  rescue
    "There was a problem with the API call"
  end

  def self.terms_in(api_response)
    api_response['response']['terms']
  end

  def self.genres_from(api_terms)
    api_terms.map{|term| puts "Failed to match genre: #{term['name']}"; term['name']}
  end
end
