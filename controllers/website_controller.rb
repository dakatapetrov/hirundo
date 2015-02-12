module Hirundo
  class WebsiteController < ApplicationController
    get '/login' do
      title = 'Welcome to Hirundo!'
      haml :login, locals: { title: title }
    end

    post '/login' do
      username = params[:username]
      password = params[:password]

      user = User.find_by_username username

      if user && user.password?(password)
        session[:username] = username
      else
        set_error "Wrong username and/or password!"
      end

      redirect_home
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

        set_success 'Your registration was successful, you can login now.'
        redirect '/login'
      else
        set_error user.errors.messages
        redirect '/register'
      end
    end

    get '/logout' do
      session.clear
      redirect_home
    end

    helpers ViewHelpers
  end
end
