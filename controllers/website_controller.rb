module Hirundo
  class WebsiteController < ApplicationController
    # helpers WebsiteHelpers

    not_found do
      @title = 'Not found'
      haml :not_found
    end

    get '/login' do
      p 'This is the login page'
    end
  end
end
