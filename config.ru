require 'rubygems'
require 'bundler'
require 'mongoid'
require 'bcrypt'

module Hirundo
  Bundler.require

  class Base < Sinatra::Base
    set :views,         File.expand_path('../views',  __FILE__)
    set :public_folder, File.expand_path('../public', __FILE__)

    enable :sessions

    register Sinatra::Flash
  end
end

Mongoid.load!('mongoid.yml')

require './helpers/application_helpers'
require './controllers/application_controller'

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

PATHS = {
  '/'           => Hirundo::WebsiteController,
}

PATHS.each { |path, controller|  map(path) { run controller } }
