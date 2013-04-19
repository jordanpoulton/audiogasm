class GigInfoProvider

  API_KEY = 'Hkockg21oUnNQEZa'
  PAGE_RESULTS = 100
  ENTRIES_PER_PAGE = 100.0

  attr_reader :location, :from, :to

  def initialize(location, from, to)
    @location = location
    @from = from
    @to = to
  end

  def get_upcoming_gigs(location, from, to)
    number_of_pages = get_expected_number_of_pages(location, from, to)
    gigs = []
    number_of_pages.times do |i|
      response = api_event_call(location, from, to, i + 1, PAGE_RESULTS)
      events = create_events_from_response(response)
      gigs += events.inject([]) do |list_of_gigs, event|
        list_of_gigs << create_gig_from_event(event) 
      end
    end
    gigs
  end

  
  def get_expected_number_of_pages(location, from, to)
    response = api_event_call(location, from, to)
    number_of_results = response["resultsPage"]["totalEntries"].to_i
    number_of_pages = (number_of_results / ENTRIES_PER_PAGE).floor
  end

  def create_events_from_response(response)
    response["resultsPage"]["results"]["event"]
  end

  def create_gig_from_event(event)
    artists   = event['performance'].map{|p| p['artist']['id'] }
    location  = event["location"]
    date      = event['start']['datetime']
    venue     = event['venue']['displayName']
    Gig.new(artists, location, date, venue) 
  end

  def api_event_call(location, from, to, page = 1, results_per_page = 100)
    Curl.get("http://api.songkick.com/api/3.0/events.json?location=sk:#{get_location_id_for(location)}&min_date=#{from}&max_date=#{to}&page=#{page}&per_page=#{PAGE_RESULTS}&apikey=#{API_KEY}")
  end

  def api_location_call_for(location, country = "uk")
    Curl.get("http://api.songkick.com/api/3.0/search/locations.json?query=#{location}%20#{country}&apikey=#{API_KEY}")
  end

  def get_location_id_for(location, country = "uk") #tested
    api_response = api_location_call_for(location, country)
    if parse_results_of(api_response)["resultsPage"]["totalEntries"].to_i == 0
      raise "Location not in database"
    else 
      parse_location_id_from(api_response)
    end
  end

  def parse_location_id_from(api_response)#tested
    parse_results_of(api_response)["resultsPage"]["results"]["location"][0]["metroArea"]["id"]
  end

  def parse_results_of(api_response) #tested
    JSON.parse(api_response.body_str)
  end
end