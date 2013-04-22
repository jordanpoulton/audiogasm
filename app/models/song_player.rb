class SongPlayer

  def self.play_song(track_url)
    Curl.get(track_url)
  end
end