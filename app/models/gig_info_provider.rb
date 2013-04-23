class GigInfoProvider

  API_KEY = 'Hkockg21oUnNQEZa'
  PAGE_RESULTS = 100
  ENTRIES_PER_PAGE = 100.0

  attr_reader :location, :from, :to, :country

  def initialize(location, from, to, country = 'uk')
    @location = location
    @from = from
    @to = to
    @country = country
  end

  def get_upcoming_gigs
    gigs = []
    expected_number_of_pages.times do |page|
      events = create_list_of_events_from_api(api_event_call(page + 1))
      gigs += events.inject([]) do |list_of_gigs, event|
        list_of_gigs << create_gig_from_event(event)
      end
    end
    gigs
  end

  def expected_number_of_pages
    number_of_results = api_event_call["resultsPage"]["totalEntries"].to_i
    number_of_pages = (number_of_results / ENTRIES_PER_PAGE).ceil
  end

  def create_list_of_events_from_api(api_call)
    api_call["resultsPage"]["results"]["event"]
  end

  def create_gig_from_event(event)
    artists     = event['performance'].map{|p| p['artist']['id'] }
    location    = event["location"]["city"]
    date        = event['start']['datetime']
    venue       = event['venue']['displayName']
    ticket_link = event['uri']
    Gig.new(artists, location, date, venue, ticket_link)
  end

  def api_event_call(page = 1)
    parse_results_of(Curl.get("http://api.songkick.com/api/3.0/events.json?location=sk:#{get_location_id}&min_date=#{@from}&max_date=#{@to}&page=#{page}&per_page=#{PAGE_RESULTS}&apikey=#{API_KEY}"))
  end

  def get_location_id
    if parse_results_of(api_location_call)["resultsPage"]["totalEntries"].to_i == 0
      raise "Location not in database"
    else
      parse_location_id_from(api_location_call)
    end
  end

  def api_location_call
    Curl.get("http://api.songkick.com/api/3.0/search/locations.json?query=#{@location}%20#{@country}&apikey=#{API_KEY}")
  end

  def parse_location_id_from(api_response)
    parse_results_of(api_response)["resultsPage"]["results"]["location"][0]["metroArea"]["id"]
  end

  def parse_results_of(api_response)
    JSON.parse(api_response.body_str)
  end
end
