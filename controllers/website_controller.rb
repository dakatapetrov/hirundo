module Hirundo
  class WebsiteController < ApplicationController
    not_found do
      @title = 'Not found'
      haml :not_found
    end

    get '/login' do
      @title = 'Welcome to Hirundo!'
      haml :login
    end

    post '/login' do
      username       = params[:username]
      password       = params[:password]

      user = User.findByUsername username

      if user && user.password?(password)
        @success = "Welcome, #{username}!"
      else
        @error = "Wrong username and/or password!"
      end

      @title = 'Welcome to Hirundo!'
      haml :login
    end

    get '/' do
      redirect '/login'
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

      if password == password_again
        user = User.new(username, password, email)
        if user.valid?
          user.save
          @success = 'Your registration was successful, you can login now.'
        else
          @error = "#{user.errors.messages}"
        end
      else
        @error = 'Both passwords should match.'
      end

      redirect '/login' unless @error
      haml :register
    end

  helpers ViewHelpers
  end
end
