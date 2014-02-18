require 'faraday'
# ask beorn to explain this gem to me.
expedia = Faraday.new(:url => "http://www.expedia.com.au")
expedia.get('/blah')

# What do you mean blah?!

destination = [
'Los Angeles, CA, United States (LAX)','Paris, France (PAR)',
'Hong Kong, Hong Kong (HKG)']


home = 'Sydney, N.S.W. (SYD-All Airports)'

cheapest_flights = Hash.new

destination.each do |destination|

  search_hash = {
    :trip => 'roundtrip',
    :leg1 => {
      :from => home,
      :to => destination,
      :departure => '15/12/2014TANYT',
    },
    :leg2 => {
      :from => destination,
      :to => home,
      :departure => '28/12/2014TANYT',
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

  # puts "The url is #{url}"

  cheapest = nil
  html = expedia.get(url).body

  html.scan(/totalCost="([0-9.]+)"/).each do |flight|
    price = flight[0].to_f
    if price < 100000
      cheapest = price if cheapest.nil? or price < cheapest
    end
  end

  if cheapest < 1000
  puts "Cheapest flight to #{destination} on Expedia is: $#{cheapest}"
  end

  cheapest_flights[destination] = "#{cheapest}"
  # I want to make a hash of all the ones I'm going.

end

# puts cheapest_flights

dream_flights = {
  "Los Angeles, CA, United States (LAX)"=>"1200",
  "Paris, France (PAR)"=>"1400",
  "Hong Kong, Hong Kong (HKG)"=>"800"
}

p cheapest_flights.inspect

# Now to write an ideal prices hash then do something like
destination.each do |destination|
 if cheapest_flights[destination] <= dream_flights[destination]
    puts "#{destination} is only #{cheapest_flights[destination]}!!"
  else
  puts "too expensive!"
  end
end

# But you see Beorn these flights aren't as cheap as what you coudl get if you didn't specify ddates, so I thought this page
# Like this qantas one -





