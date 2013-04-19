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

  def get_area_id_for(location, country = "uk")
    api_response = api_location_call_for(location, country)
    parse_area_id_from(api_response)
  end

  def parse_area_id_from(api_response)
    parse_results_of(api_response)["resultsPage"]["results"]["location"][0]["metroArea"]["id"]
  end

  def parse_results_of(api_response)
    JSON.parse(api_response.body_str)
  end

  def get_number_of_pages_from(json_parsed_results)
    number_of_results = json_parsed_results["resultsPage"]["totalEntries"].to_i
    number_of_pages = (number_of_results / ENTRIES_PER_PAGE).ceil
  end

  def get_upcoming_gigs_by_date_and_location(location, from, to)
    api_response = api_event_call(location, from, to)
    parsed_api_response = parse_results_of(api_response)
    number_of_pages = get_number_of_pages_from(parsed_api_response)
    
    gigs = []

    number_of_pages.times do |i|
      api_response = api_event_call(location, from, to, i, PAGE_RESULTS)

      parsed_api_response = parse_results(api_response)
      events = parsed_api_response["resultsPage"]["results"]["event"]
      gigs += events.inject([]) do |list_of_gigs, event|
        location  = event["location"]
        venue     = event['venue']['displayName']
        date      = event['start']['datetime']
        artists   = event['performance'].map{|p| p['artist']['id'] }
        list_of_gigs << Gig.new(location, venue, date, artists) 
      end
    end
    gigs
  end

  # location_api_call
  # event_api_call

  # api_call

  def api_event_call(location, from, to, page = 1, results_per_page = 100)
    Curl.get("http://api.songkick.com/api/3.0/events.json?location=sk:#{area_id_for(location)}&min_date=#{from}&max_date=#{to}&page=#{page}&per_page=#{PAGE_RESULTS}&apikey=#{API_KEY}")
  end

  def api_location_call_for(location, country)
    Curl.get("http://api.songkick.com/api/3.0/search/locations.json?query=#{location}%20#{country}&apikey=#{API_KEY}")
  end
end