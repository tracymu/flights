require 'wombat'

flights = Wombat.crawl do
  base_url "http://www.cathaypacific.com"
  path "/cx/en_AU/latest-offers.html"
  # Not sure how to do it from Sydney

  results "css=.bullet-list", :iterator do
    # The problem here being a) it is a list of countries and b) it is returning a string of cities and prices "from"
  end
end

print flights["results"]

flights["results"].each do |result|
  p "Is this happening?"
end

