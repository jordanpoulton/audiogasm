require 'curb'
require 'json'
# require 'echonest-ruby-api'



class EchonestApi

  # attr_accessible :title, :body
  ECHONEST_API_KEY = ENV['ECHONEST_API_KEY']

  RDIO_KEY = ENV['RDIO_KEY']
  RDIO_SECRET = ENV['RDIO_SECRET']

  RDIO_API = RdioApi.new(:consumer_key => RDIO_KEY, :consumer_secret => RDIO_SECRET)



  # def self.get_echonest_artist_id(songkick_artist_id)
  #   http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{songkick_artist_id}&format=json")
  #   json_hash = JSON.parse(http.body_str)
  #   json_hash['response']['artist']['id']
  # end

  def self.get_rdio_artist_id(songkick_artist_id)
    http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{songkick_artist_id}&bucket=id:rdio-US&format=json")
    json_hash = JSON.parse(http.body_str)
    artist_id = json_hash['response']['artist']['foreign_ids'].map{|e| e["foreign_id"] }.first
    /\w+\z/.match(artist_id).to_s
  end

  def self.get_song_from_rdio(songkick_id, count =1)
    rdio_artist_id = get_rdio_artist_id(songkick_id)
    get_track = RDIO_API.getTracksForArtist(:artist => "#{rdio_artist_id}", :count => "#{count}")[0]
    get_track_embed_url = get_track.embedUrl
  end

  def self.get_artist_name(artist_id)
    http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{artist_id}&format=json")
    json_hash = JSON.parse(http.body_str)
    if json_hash["response"]["status"]["message"] == "Success"
      json_hash['response']['artist']['name']
    else
      return "Couldn't get artist name"
    end
  end

  def self.get_artist_genres_by_id(artist_id)
    http = Curl.get("http://developer.echonest.com/api/v4/artist/terms?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{artist_id}&format=json")
    json_hash = JSON.parse(http.body_str)
    if json_hash["response"]["status"]["message"] == "Success"
      json_hash['response']['terms'].map{|e| e["name"] }
    else
      print ["Couldn't get artist Genres"]
    end
  end

  def self.get_artist_genres_by_weight(artist_id, weight)
    http = Curl.get("http://developer.echonest.com/api/v4/artist/terms?api_key=#{ECHONEST_API_KEY}&name=#{artist_id}&format=json")
    json_hash = JSON.parse(http.body_str)
    json_hash['response']['terms'].select{|w| w["weight"] > weight }.map{|e| e["name"] }
  end

  def self.check_artist_is_of_genre(artist_id, genre)
    array = get_artist_genres_by_id(artist_id)
    array.detect { |item| return true if item == genre}
    false
    unless array.nil?
      debugger
      array.detect { |item| item == genre ? artist_id : "Artist doesn't match genre" }
    else return "Array is empty"
    end
  end
end


# http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=SYT5EOFXZFDBJFV2P&id=songkick:artist:288696&format=json")
# => #<Curl::Easy http://developer.echonest.com/api/v4/artist/profil>

# http.body_str
# => "{\"response\": {\"status\": {\"version\": \"4.2\", \"code\": 0, \"message\": \"Success\"}, \"artist\": {\"id\": \"AR2ZPMX1187FB4E4B6\", \"name\": \"Vampire Weekend\"}}}"
# # 1.9.3-p392 :019 >

# artist = Echonest::Artist.new('SYT5EOFXZFDBJFV2P', nil,  [{:catalog => 'artists', :foreign_id => '5380281'}])

# http = Curl.get("http://developer.echonest.com/api/v4/artist/terms?api_key=#{API_KEY}&name=#{artist_name}&format=json")

# --- Rdio interaction -----

http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=SYT5EOFXZFDBJFV2P&id=AR2ZPMX1187FB4E4B6&bucket=id:rdio-US&format=json")

http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=SYT5EOFXZFDBJFV2P&id=songkick:artist:253846&bucket=id:rdio-US&format=json")

