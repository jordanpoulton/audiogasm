class SongKickApi

  API_KEY = 'Hkockg21oUnNQEZa'
  PAGE_RESULTS = 100
  @artists_array = []

  def self.area_id_for_location(location, country = "uk")
    http = Curl.get("http://api.songkick.com/api/3.0/search/locations.json?query=#{location}%20#{country}&apikey=#{API_KEY}")
    JSON.parse(http.body_str)["resultsPage"]["results"]["location"][0]["metroArea"]["id"]

  end

  def self.parse_results(http_body_str)
    JSON.parse(http_body_str)
  end

  def self.calculate_total_entries(json_parsed_results)
    total_entries = json_parsed_results["resultsPage"]["totalEntries"].to_i
    total_pages = (total_entries / 100.00).ceil
  end

  def self.get_upcoming_artists_by_date_and_location(location, min_date, max_date)
    http = Curl.get("http://api.songkick.com/api/3.0/events.json?location=sk:#{SongKickApi.area_id_for_location(location)}&min_date=#{min_date}&max_date=#{max_date}&page=1&per_page=#{PAGE_RESULTS}&apikey=#{API_KEY}")

    result = SongKickApi.parse_results(http.body_str)
    total_pages = SongKickApi.calculate_total_entries(result)
    @artists_array=[]

    total_pages.times do |i|
        http = Curl.get("http://api.songkick.com/api/3.0/events.json?location=sk:#{SongKickApi.area_id_for_location(location)}&min_date=#{min_date}&max_date=#{max_date}&page=#{i+1}&per_page=#{PAGE_RESULTS}&apikey=Hkockg21oUnNQEZa")

        result = JSON.parse(http.body_str)


        @artists_array << result["resultsPage"]["results"]["event"].map {|event| event["performance"].map {|performance| performance["artist"]["id"]}}.flatten
    end
    return @artists_array.flatten
  end
end
