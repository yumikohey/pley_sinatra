# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
ENV['CONSUMER_KEY'] = "wGEgF6SN0OuoDyzv7WE2og"
ENV['CONSUMER_SECRET'] = "SxeEJ0HjyC-N6Y9QENyUTyw5WRE"
ENV['TOKEN'] = "zp-wJQ5M7-VCbVnL09IFnI0am2myQDN0"
ENV['TOKEN_SECRET'] = "l06vjOjl3HtkN8i7Max4YYPuMNU"
ENV['GOOGLE_KEY'] = "AIzaSyBeRCw4xuS5zbC1L4zEWqF8BWrIKHbphHs"

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'yelp'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

configure do
  # By default, Sinatra assumes that the root is the file that calls the configure block.
  # Since this is not the case for us, we set it manually.
  set :root, APP_ROOT.to_path
  # See: http://www.sinatrarb.com/faq.html#sessions
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhh'

  # Set the views to
  set :views, File.join(Sinatra::Application.root, "app", "views")
end

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

# Yelp.client.configure do |config|
#   config.consumer_key = "wGEgF6SN0OuoDyzv7WE2og"
#   config.consumer_secret = "SxeEJ0HjyC-N6Y9QENyUTyw5WRE"
#   config.token = 'zp-wJQ5M7-VCbVnL09IFnI0am2myQDN0'
#   config.token_secret = 'l06vjOjl3HtkN8i7Max4YYPuMNU'
# end

