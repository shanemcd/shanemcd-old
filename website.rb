require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'haml'
require './models'

set :username,'admin'
set :token,'maketh1$longandh@rdtoremember'
set :password,'8Dinosaurs'

helpers do
  def admin? ; request.cookies[settings.username] == settings.token ; end
  def protected! ; halt [ 401, 'Get out my house!' ] unless admin? ; end
end

get '/' do
  @articles = Articles.all
 erb :home
end

get '/admin' do
  erb :admin
end

post '/login' do
  if params['username']==settings.username&&params['password']==settings.password
      response.set_cookie(settings.username,settings.token) 
      redirect '/articlelist'
    else
      "Get out my house!"
    end
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

get('/logout'){ response.set_cookie(settings.username, false) ; redirect '/' }

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