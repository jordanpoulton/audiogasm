require 'echonest-ruby-api'



class EchonestApi
  # attr_accessible :title, :body

  def get_artist_name(artist_id)
  
  end
end


# http = Curl.get("http://developer.echonest.com/api/v4/artist/profile?api_key=SYT5EOFXZFDBJFV2P&id=songkick:artist:288696&format=json")
# => #<Curl::Easy http://developer.echonest.com/api/v4/artist/profil>

# http.body_str
# => "{\"response\": {\"status\": {\"version\": \"4.2\", \"code\": 0, \"message\": \"Success\"}, \"artist\": {\"id\": \"AR2ZPMX1187FB4E4B6\", \"name\": \"Vampire Weekend\"}}}"
# # 1.9.3-p392 :019 >

# artist = Echonest::Artist.new('SYT5EOFXZFDBJFV2P', nil,  [{:catalog => 'artists', :foreign_id => '5380281'}])

  # artist = Echonest::Artist.new('SYT5EOFXZFDBJFV2P', nil,  [{:catalog => 'artists', :foreign_id => 'artist_id'}])
