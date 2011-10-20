require 'sinatra'
require 'data_mapper'
require './website'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/my.db")

class Articles
  include DataMapper::Resource
  property :id,           Serial
  property :articleName,  Text, :required => true
  property :articleBody,  Text
end

DataMapper.finalize.auto_upgrade!
