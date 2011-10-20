require 'sinatra'
require 'data_mapper'
require './website'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/my.db")

class Articles
  include DataMapper::Resource
  property :id,           Serial
  property :articleName,  Text, :required => true
  property :articleBody,  Text
end

DataMapper.finalize.auto_upgrade!

a = Articles.new
a.articleName = "Test"
a.articleBody = "<div><p>Elit et aliqua, +1 american apparel yr farm-to-table fap mollit trust fund readymade. Sustainable wayfarers bicycle rights irony odio in, thundercats laboris ea salvia sunt veniam seitan artisan. Cardigan letterpress locavore fanny pack et. Ea salvia voluptate cupidatat helvetica, vero sustainable farm-to-table. Art party VHS +1, excepteur high life mollit helvetica wes anderson dolore commodo PBR single-origin coffee dreamcatcher aliqua. Officia master cleanse salvia aesthetic. Photo booth 8-bit vero, cillum accusamus in locavore.</p></div>"
a.save