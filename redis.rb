require 'ohm'
require './lib/ohm.rb'

class Destination < Ohm::Model
  attribute :city
  attribute :country
  set :deals, :Deal
  index :city
end

class Deal < Ohm::Model
  attribute :price
  reference :airline, :Airline
end

class Airline < Ohm::Model
  attribute :name
  index :name
end

airline = Airline.find_or_create(:name => "Qantas")

loc = Destination.find_or_create(:city => "Paris")
loc.update(:country => "France") if loc.country.nil?

deal = loc.deals.find_or_create(:airline => airline)
deal.price = 950
deal.save

puts "Price of flight with #{airline.name} to #{loc.city} is $#{deal.price}"