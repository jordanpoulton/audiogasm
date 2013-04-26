class SongProvider

  ECHONEST_API_KEY = ENV['ECHONEST_API_KEY']

  RDIO_KEY = ENV['RDIO_KEY']
  RDIO_SECRET = ENV['RDIO_SECRET']

  @rdio_api = RdioApi.new(:consumer_key => RDIO_KEY, :consumer_secret => RDIO_SECRET)



  def self.get_track_embed_url(artist_id, count =1)
    artist = SongProvider.get_rdio_artist_id(artist_id)
    tracks = @rdio_api.getTracksForArtist(:artist => "#{artist}", :count => "#{count}")
    raise "Tracks for #{artist} not found" if tracks.empty?
    track_url = tracks.first.embedUrl
  end

  private

  def self.get_rdio_artist_id(artist_id)
    begin
      make_rdio_artist_id_readable(
        turn_songkick_artist_id_into_rdio_artist_id(
      parsed_api_call(artist_id)))
    rescue
      "Artist not understood by Rdio"
    end
  end

  def self.turn_songkick_artist_id_into_rdio_artist_id(songkick_artist_id)
    songkick_artist_id['response']['artist']['foreign_ids'].map{|e| e["foreign_id"] }.first
  end

  def self.make_rdio_artist_id_readable(rdio_artist_id)
    /\w+\z/.match(rdio_artist_id).to_s
  end

  def self.parsed_api_call(artist_id)
    begin
      JSON.parse(Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{artist_id}&bucket=id:rdio-US&format=json").body_str)
    rescue
      "Artist not understood by Rdio"
    end
  end
end
