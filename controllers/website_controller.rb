module Hirundo
  class WebsiteController < ApplicationController
    get '/' do
      redirect '/login'
    end

    get '/login' do
      title = 'Welcome to Hirundo!'
      haml :login, locals: { title: title }
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
