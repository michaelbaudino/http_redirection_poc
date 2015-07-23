require 'rack'

require './app.rb'

use Rack::Reloader
run App
