class SongProvider

  ECHONEST_API_KEY = ENV['ECHONEST_API_KEY']

  RDIO_KEY = ENV['RDIO_KEY']
  RDIO_SECRET = ENV['RDIO_SECRET']

  RDIO_API = RdioApi.new(:consumer_key => RDIO_KEY, :consumer_secret => RDIO_SECRET)

  def self.get_rdio_artist_id(songkick_artist_id)
    http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{songkick_artist_id}&bucket=id:rdio-US&format=json")
    if json_hash = JSON.parse(http.body_str)["response"]["status"]["message"] == "The Identifier specified does not exist"
      raise 'Invalid SongKick_artist_id'
    else
      json_hash = JSON.parse(http.body_str)
    end
    @rdio_artist_id = json_hash['response']['artist']['foreign_ids'].map{|e| e["foreign_id"] }.first
    /\w+\z/.match(@rdio_artist_id).to_s
  end

   def self.get_song_from_rdio(songkick_artist_id, count =1)
    rdio_artist_id = SongProvider.get_rdio_artist_id(songkick_artist_id)
    get_track = RDIO_API.getTracksForArtist(:artist => "#{rdio_artist_id}", :count => "#{count}")[0]
    track_url = get_track.embedUrl
  end
end