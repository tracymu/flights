require 'sinatra'
require 'datamapper'


######  All this code commented out is to link Sinatra to a database  ###########
# I didn't want to mess around with it too much in case I screwed it up, but ...
# I include this for your information....
# We will also need a new section of redis database for email and destinaton.

# DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")

# class Note
#   include DataMapper::Resource
#   property :id, Serial
#   property :content, Text, :required => true
#   property :complete, Boolean, :required => true, :default => false
#   property :created_at, DateTime
#   property :updated_at, DateTime
# end

# DataMapper.finalize.auto_upgrade!


get '/' do
  'Our Flights App'
end

get '/form'  do
  erb :form
end

post '/form' do
  "Once we figure this out, we'll send you an email if flights to #{params[:destination]} go on sale!"
end

