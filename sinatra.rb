require 'sinatra'
# I also tried to use the shotgun gem...for this...but it didn't work this time.

get '/' do
  'Our Flights App'
end

get '/form'  do
  erb :form
end

post '/form' do
  "Once we figure this out, we'll send you an email if flights to #{params[:destination]} go on sale!"
end