require 'wombat'
require './redis.rb'

flights = Wombat.crawl do
  base_url "http://www.emirates.com"
  path "/au/english/"


  results "css= .subItem-3" , :iterator do
    # This is in the top menu. It can't work can it...because it has some java scripty thing hiding it?
    city 'css=.underlined'
    price 'css=.rightAligned'
  end
end

print flights["results"]
