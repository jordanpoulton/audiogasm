class ArtistFilterInfoProvider

  ECHONEST_API_KEY = ENV['ECHONEST_API_KEY']


  def self.get_artist_genres(artist_id)
      genres_from(
        terms_in(
          parsed_api_call(artist_id)))
    rescue
      "Couldn't find artist"
  end

  def self.check_artist_is_of_genre(artist_id, genre)
    artist_genres = get_artist_genres(artist_id)
    artist_genres.include?(genre)
  end

  def self.parsed_api_call(artist_id)
    JSON.parse(Curl.get("http://developer.echonest.com/api/v4/artist/terms?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{artist_id}&format=json").body_str)
  end

  def self.terms_in(api_response)
    api_response['response']['terms']
  end

  def self.genres_from(api_terms)
    api_terms.map{|term| term['name']}
  end
end
