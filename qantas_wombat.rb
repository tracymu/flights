require 'wombat'

flights = Wombat.crawl do
  base_url "http://www.qantas.com.au"
  path "/travel/airlines/international-flight-specials/from-sydney/economy/global/en"


  results "css=#flightSpecialsResults > .result", :iterator do
    city 'css=.desName_string'
    price 'css=.dynPrice'
  end
end

print flights["results"]

flights["results"].each do |result|
  p "#{result['city']} is $#{result['price']}"
end

