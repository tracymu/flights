require 'wombat'
require './redis.rb'

flights = Wombat.crawl do
  base_url "http://www.singaporeair.com"
  path "/SAA-flow.form"


  results "css=#fare1 .fareDeal_1", :iterator do
    city 'css=.from'
    price 'css=.price'
  end
end

# print flights["results"]


singapore = Airline.find_or_create(:name => "Singapore Air")

flights["results"].each do |result|
  destination = Destination.find_or_create(:city => result['city'])
  deal = destination.deals.find_or_create(:airline => singapore)
  deal.price = result['price'].match(/\d+/).to_s.to_i
  deal.save
  p "#{result['city']} is $#{deal.price}"
end


# Two columns of results...