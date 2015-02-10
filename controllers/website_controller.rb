module Hirundo
  class WebsiteController < ApplicationController
    get '/' do
      redirect '/login'
    end

    get '/login' do
      title = 'Welcome to Hirundo!'
      haml :login, locals: { title: title }
    end

    post '/login' do
      username       = params[:username]
      password       = params[:password]

      user = User.findByUsername username

      if user && user.password?(password)
        success = "Welcome, #{username}!"
      else
        error = "Wrong username and/or password!"
      end

      title = 'Welcome to Hirundo!'
      haml :login, locals: {title: title, error: error, success: success}
    end

    get '/register' do
      title = 'Register'
      haml :register, locals: { title: title }
    end

    post '/register' do
      username              = params[:username]
      password              = params[:password]
      password_confirmation = params[:password_confirmation]
      email                 = params[:email]

      user = User.new(username, password, password_confirmation, email)
      if user.valid?
        user.save
        success = 'Your registration was successful, you can login now.'
      else
        error = user.errors.messages
      end

      if success
        haml :login, locals: { title: 'Welcome to Hirundo!', success: success }
      else
        haml :register, locals: { title: 'Register', error: error }
      end
    end

  helpers ViewHelpers
  end
end
