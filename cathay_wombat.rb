require 'wombat'

flights = Wombat.crawl do
  base_url "http://www.cathaypacific.com"
  path "/cx/en_AU/latest-offers.html"
  # Not sure how to do it from Sydney

  results "css=.offerPkgLst btm", :iterator do
    city 'css=.ctry'
    price 'css = .costfrom cost'
  end
end

print flights["results"]

# flights["results"].each do |result|
#   p "Is this happening?"
# end

