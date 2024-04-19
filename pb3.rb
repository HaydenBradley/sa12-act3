require 'httparty'
require 'json'

api_key = 'YOUR_EVENTBRITE_API_KEY'
location = 'New York'


url = "https://www.eventbriteapi.com/v3/events/search/?location.address=#{location}&token=#{api_key}"


response = HTTParty.get(url)

if response.success?

  events_data = JSON.parse(response.body)


  events_data['events'].each do |event|
    name = event['name']['text']
    venue = event['venue']['name']
    start_time = event['start']['local']
    end_time = event['end']['local']

    puts "Event: #{name}"
    puts "Venue: #{venue}"
    puts "Start Time: #{start_time}"
    puts "End Time: #{end_time}"
    puts "--------------------------"
  end
else
  puts "Failed to fetch events for #{location}."
end
