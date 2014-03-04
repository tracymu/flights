require 'wombat'
require './redis.rb'

flights = Wombat.crawl do
  base_url "http://www.qantas.com.au"
  path "/travel/airlines/international-flight-specials/from-sydney/economy/global/en"


  results "css=#flightSpecialsResults > .result", :iterator do
    city 'css=.desName_string'
    price 'css=.dynPrice'
  end
end

# print flights["results"]

qantas = Airline.find_or_create(:name => "Qantas")

flights["results"].each do |result|
  city = result["city"].match(/[^(]*/).to_s.strip
  destination = Destination.find_or_create(:city => city)
  deal = destination.deals.find_or_create(:airline => qantas)
  deal.price = result["price"].to_i
  deal.save
  p "#{city} is $#{result['price']}"
end