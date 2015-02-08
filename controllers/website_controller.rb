module Hirundo
  class WebsiteController < ApplicationController
    # helpers WebsiteHelpers

    not_found do
      @title = 'Not found'
      haml :not_found
    end

    get '/login' do
      @title = 'Welcome to Hirundo!'
      haml :login
    end
  end
end
