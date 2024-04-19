require 'httparty'
require 'json'

api_key = '17a5c213f091dfe47cc162f01c2ccdc2'
city = 'London'

# URL for OpenWeatherMap API
url = "http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{api_key}"

# Send GET request to OpenWeatherMap API
response = HTTParty.get(url)

# Print out the response body for debugging
puts response.body

# Check if request was successful
if response.success?
  # Parse JSON response
  weather_data = JSON.parse(response.body)

  # Extract temperature, humidity, and weather conditions
  temperature_kelvin = weather_data['main']['temp']
  humidity = weather_data['main']['humidity']
  weather_conditions = weather_data['weather'][0]['description']

  # Convert temperature from Kelvin to Celsius
  temperature_celsius = temperature_kelvin - 273.15

  # Display weather information
  puts "Weather in #{city}:"
  puts "Temperature: #{temperature_celsius.round(2)}°C"
  puts "Humidity: #{humidity}%"
  puts "Weather Conditions: #{weather_conditions}"
else
  puts "Failed to fetch weather data for #{city}."
end
