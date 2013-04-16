require 'echonest-ruby-api'
require 'curb'
require 'json'



class EchonestApi

  API_KEY = "SYT5EOFXZFDBJFV2P"
  # attr_accessible :title, :body

<<<<<<< HEAD
  def get_artist_name(artist_id)
  
=======
  # artist = Echonest::Artist.new('Weezer', 'SYT5EOFXZFDBJFV2P')

  # artist.terms

  def self.get_artist_genres_by_id(artist_id)
    http = Curl.get("http://developer.echonest.com/api/v4/artist/terms?api_key=#{API_KEY}&id=#{artist_id}&format=json")
    json_hash = JSON.parse(http.body_str)
    json_hash['response']['terms'].map{|e| e["name"] }
>>>>>>> 251d5d690d69b22e4330122deff2b475e204ec20
  end
end


# http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=SYT5EOFXZFDBJFV2P&id=songkick:artist:288696&format=json")
# => #<Curl::Easy http://developer.echonest.com/api/v4/artist/profil>

# http.body_str
# => "{\"response\": {\"status\": {\"version\": \"4.2\", \"code\": 0, \"message\": \"Success\"}, \"artist\": {\"id\": \"AR2ZPMX1187FB4E4B6\", \"name\": \"Vampire Weekend\"}}}"
# # 1.9.3-p392 :019 >

# artist = Echonest::Artist.new('SYT5EOFXZFDBJFV2P', nil,  [{:catalog => 'artists', :foreign_id => '5380281'}])

  # artist = Echonest::Artist.new('SYT5EOFXZFDBJFV2P', nil,  [{:catalog => 'artists', :foreign_id => 'artist_id'}])
