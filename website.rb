require 'rubygems'
require 'sinatra'
require 'haml'

get '/' do
  haml :home
end

get '/about' do
  haml :about
end

get '/mywork' do
  haml :mywork
end

get '/contact' do
  haml :contact
end

get '/print' do
  haml :print
end

get '/photography' do
  haml :photography
end