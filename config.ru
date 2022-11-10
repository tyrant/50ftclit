# Prod's Phusion-Passenger/Nginx needs this file to connect Nginx to 50ftclit, turns out.

require 'rubygems'
require 'bundler'

Bundler.require

require './app.rb'

use Rack::ShowExceptions
run Sinatra::Application