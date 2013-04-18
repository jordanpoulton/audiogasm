class ArtistGigInfoFinder

attr_reader :location, :min_date, :max_date

  def initialize(location, min_date, max_date)
    @location = location
    @min_date = min_date
    @max_date = max_date
  end

  def get_gigs_info
    @artists_gigs_info = []
  end
end