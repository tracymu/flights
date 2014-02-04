require 'faraday'

expedia = Faraday.new(:url => "http://www.expedia.com.au")
expedia.get('/blah')

home = 'Sydney, N.S.W. (SYD-All Airports)'
destination = 'HI, United States (HNL-Honolulu Intl.)'

search_hash = {
  :trip => 'roundtrip',
  :leg1 => {
    :from => home,
    :to => destination,
    :departure => '08/04/2014TANYT',
  },
  :leg2 => {
    :from => destination,
    :to => home,
    :departure => '25/04/2014TANYT',
  },
  :passengers => {
    :children => '0',
    :adults => '1',
    :seniors => '0',
    :infantinlap => 'Y',
  },
  :options => {
    :cabinclass => 'coach',
    :nopenalty => 'N',
    :sortby => 'price',
  },
  :mode => 'search',
}

url = ''
search_hash.each do |param, object|
  url << '&' + param.to_s + '='
  if object.class == Hash
    object.each do |key, str|
      url << key.to_s + ':' + URI.escape(str) + ','
    end
    url = url[0..-2] # removes the last comma
  else
    url << object
  end
end
url = "/Flights-Search?" + url[1..-1] # removes the first ampersand

puts "The url is #{url}"

cheapest = nil
html = expedia.get(url).body

html.scan(/totalCost="([0-9.]+)"/).each do |flight|
  price = flight.first.to_f
  cheapest = price if cheapest.nil? or price < cheapest
end
puts "Cheapest flight from Expedia is: $#{cheapest}"
