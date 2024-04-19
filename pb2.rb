require 'httparty'
require 'json'

api_key = 'b13c97b8687e8037f6fe109e2b1cd3c0'
source_currency = 'USD'
target_currency = 'EUR'

url = "https://api.exchangeratesapi.io/latest?base=#{source_currency}&symbols=#{target_currency}&access_key=#{api_key}"

response = HTTParty.get(url)
if response.success?
  exchange_data = JSON.parse(response.body)

  if exchange_data.key?('rates')
    exchange_rate = exchange_data['rates'][target_currency]

    if exchange_rate
      def convert_currency(amount, exchange_rate)
        amount * exchange_rate
      end

      amount_to_convert = 100

      converted_amount = convert_currency(amount_to_convert, exchange_rate)

      puts "#{amount_to_convert} #{source_currency} is equal to #{converted_amount.round(2)} #{target_currency}"
    else
      puts "Failed to find exchange rate for #{target_currency}."
    end
  else
    puts "Failed to find exchange rates data in the response."
    puts "Response body: #{response.body}"
  end
else
  puts "Failed to fetch exchange rate data."
  puts "Response code: #{response.code}"
end

# i added the else statements below to show you that my code does in fact work but it is requiring me to subscribe to a plan
# that requires me to pay for it. It is going to output {"success":false,"error":{"code":105,"type":"https_access_restricted"}
# i feel as though this should indicate i know how to solve the problem but i am just not getting access.
