class GigFactory

  def self.valid_gig
    Gig.new(:artists => 'radiohead')
  end
end