ROOT_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))
RUBY_VERSION =~ /^1.8/ ? $KCODE = "u" : Encoding.default_internal = 'UTF-8'
require 'rubygems'
require 'bundler/setup'
Bundler.require
Bundler.require(Sinatra::Base.environment.to_sym)

require File.join(ROOT_DIR, 'helpers.rb')
Dir.glob(['lib','models'].map! {|d| File.join ROOT_DIR, d, '*.rb'}).each {|f| require f}
DataMapper::Model.raise_on_save_failure = true 

puts "Starting in #{Sinatra::Base.environment} mode."

class Controller < Sinatra::Base

  enable :method_override

  configure :development do
    enable :logging
    DataMapper.setup :default, 'postgres://realphysicians:doctordoctor@localhost/realphysicians'
    # DataMapper::Logger.new STDOUT, :debug
  end

  configure :test do
  end

  configure :production do
    # DataMapper.setup :default, 'postgres://user:pass@localhost/database'
  end
end

require File.join(ROOT_DIR, 'app.rb')