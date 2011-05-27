require 'rubygems'
require 'bundler'
Bundler.require

# Configuration for processing and encoding
app = Dragonfly::App[:media]
app.configure_with(:imagemagick)
app.datastore = Dragonfly::DataStorage::MongoDataStore.new :db => Mongo::Connection.from_uri(ENV['MONGO_URL'])

app.configure do |c|
  #c.log = ::Rails.logger
  c.url_format = '/media/:job/:basename.:format'
  c.analyser.register(Dragonfly::Analysis::FileCommandAnalyser)
end

run Dragonfly::App[:media]

