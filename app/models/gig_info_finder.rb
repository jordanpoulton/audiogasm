class GigInfoFinder

attr_accessor :location, :from, :to

  def initialize(location, from, to)
    @location = location
    @from = from
    @to = to
  end

  def self.get_gig_info(location, from, to)
    GigInfoProvider.provide_gig_info
  end
end