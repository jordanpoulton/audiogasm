class ArtistGigInfoFinder

attr_reader :location, :min_date, :max_date

def initialize(location, min_date)
  @location = location
  @min_date = min_date
  raise "min date must be a date" unless min_date.is_a? Date
end

end