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

    get '/register' do
      @title = 'Register'
      haml :register
    end

    post '/register' do
      username       = params[:username]
      password       = params[:password]
      password_again = params[:password_again]
      email          = params[:email]

      user = User.new(username, password, email)

      if user.valid?
        user.save
        p 'Valid'
      else
        p "#{user.errors.messages}"
      end
    end
  end
end
