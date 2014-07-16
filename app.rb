require 'sinatra'
require 'haml'

load 'home.rb'

get '/about' do
  haml :about
end
