require 'curb'
require 'json'
# require 'echonest-ruby-api'



class EchonestApi

  # attr_accessible :title, :body

  # def self.get_echonest_artist_id(songkick_artist_id)
  #   http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{songkick_artist_id}&format=json")
  #   json_hash = JSON.parse(http.body_str)
  #   json_hash['response']['artist']['id']
  # end

  def self.get_rdio_artist_id(songkick_artist_id)
    http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=#{ECHONEST_API_KEY}&id=songkick:artist:#{songkick_artist_id}&bucket=id:rdio-US&format=json")
    json_hash = JSON.parse(http.body_str)
    artist_id = json_hash['response']['artist']['foreign_ids'].map{|e| e["foreign_id"] }.first
    /\w+\z/.match(artist_id)
  end

  def self.get_artist_genres_by_id(artist_id) 
    http = Curl.get("http://developer.echonest.com/api/v4/artist/terms?api_key=#{ECHONEST_API_KEY}&id=#{artist_id}&format=json")
    json_hash = JSON.parse(http.body_str)
    json_hash['response']['terms'].map{|e| e["name"] }
  end

  # def self.get_artist_genres_by_name(artist_name)
  #   http = Curl.get("http://developer.echonest.com/api/v4/artist/terms?api_key=#{ECHONEST_API_KEY}&name=#{artist_name}&format=json")
  #   json_hash = JSON.parse(http.body_str)
  #   json_hash['response']['terms'].map{|e| e["name"] }
  # end

  def self.get_artist_genres_by_weight(artist_id, weight)
    http = Curl.get("http://developer.echonest.com/api/v4/artist/terms?api_key=#{ECHONEST_API_KEY}&name=#{artist_id}&format=json")
    json_hash = JSON.parse(http.body_str)
    json_hash['response']['terms'].select{|w| w["weight"] > weight }.map{|e| e["name"] }
  end

  def self.check_artist_is_of_genre(artist_id, genre)
    array = get_artist_genres_by_id(artist_id)
    array.each { |item| return true if item == genre}
    false
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

