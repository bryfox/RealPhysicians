ROOT_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))
RUBY_VERSION =~ /^1.8/ ? $KCODE = "u" : Encoding.default_internal = 'UTF-8'
require 'rubygems'
require 'bundler/setup'
Bundler.require
Bundler.require(Sinatra::Base.environment.to_sym)

Dir.glob(['lib'].map! {|d| File.join ROOT_DIR, d, '*.rb'}).each {|f| require f}

STRINGS = YAML::load( File.open( File.join(ROOT_DIR, '/config/strings.yaml') ) )

require File.join(ROOT_DIR, 'helpers.rb')
Dir.glob(['models'].map! {|d| File.join ROOT_DIR, d, '*.rb'}).each {|f| require f}
DataMapper::Model.raise_on_save_failure = true 

puts "Starting in #{Sinatra::Base.environment} mode."

class Controller < Sinatra::Base

  set :public, File.join(ROOT_DIR, '/public')

  configure :development do
    DataMapper.setup :default, 'postgres://realphysicians:doctordoctor@localhost/realphysicians'
    DataMapper::Logger.new STDOUT, :debug
    enable :logging
  end

  configure :production do
    DataMapper.setup :default, ENV['DATABASE_URL']
  end
end

require File.join(ROOT_DIR, 'app.rb')