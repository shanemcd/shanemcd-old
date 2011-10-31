require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'haml'
require './models'

# Regular Routes
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
# End Routes

# Aricle Routes
get '/articles/:id' do
  @article = Articles.get params[:id]
  erb :article
end

get '/add' do
  protected!
  erb :add
end

post '/add' do
  a = Articles.new
  a.articleName = params[:title]
  a.articleBody = params[:content]
  a.save
  redirect '/'
end

get '/articlelist' do
  protected!
  @articles = Articles.all
  erb :articlelist
end

get '/edit/:id' do
  protected!
  @article = Articles.get params[:id]
  erb :edit
end

put '/add' do
  protected!
  a = Articles.new
  a.articleName = params[:title]
  a.articleBody = params[:content]
  a.save
  redirect '/'
end

put '/article/:id' do
  a = Articles.get params[:id]
  a.articleName = params[:title]
  a.articleBody = params[:content]
  a.save
  redirect '/'
end

get '/article/:id/delete' do
  protected!
  @article = Articles.get params[:id]
  erb :delete
end

delete '/:id' do
  protected!
  a = Articles.get params[:id]
  a.destroy
  redirect '/'
end
# End Articles

# Admin Stuff
helpers do

  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', ENV['ADMIN_PASS']]
  end

end
# End Admin