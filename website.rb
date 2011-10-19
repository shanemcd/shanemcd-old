require 'rubygems'
require 'sinatra'
require './articles'

get '/' do
  @articles = Articles.all
 erb :home
end

get '/about' do
  erb :about
end

get '/work' do
  erb :mywork
end

get '/contact' do
  erb :contact
end

get '/print' do
  erb :print
end

get '/photography' do
  erb :photography
end

get '/articles/:id' do
  @article = Articles.get params[:id]
  erb :article
end