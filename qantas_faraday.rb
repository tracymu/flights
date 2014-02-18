require 'faraday'
# ask beorn to explain this gem to me.
qantas = Faraday.new(:url => "http://www.qantas.com.au")


  html = qantas.get("/travel/airlines/international-flight-specials/from-sydney/economy/global/en").body

  html.scan(/class="dynPrice">([0-9.]+)"/).each do |flight|
    price = flight[0].to_f
    if price < 100000
      cheapest = price if cheapest.nil? or price < cheapest
    end
  end

#   if cheapest < 1000
#   puts "Cheapest flight to #{destination} on Expedia is: $#{cheapest}"
#   end

#   cheapest_flights[destination] = "#{cheapest}"
#   # I want to make a hash of all the ones I'm going.

# end

# # puts cheapest_flights
puts html

# This is not right, because it is going to the all flights page