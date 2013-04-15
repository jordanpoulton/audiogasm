require 'songkickr'
remote = Songkickr::Remote.new API_KEY

class SongKickApi

  def self.area_id_for_location(location)
    @location = location
    metro_area_id = @location.values_at(:id)
  end

end
