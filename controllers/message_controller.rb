module Hirundo
  class MessageController < ApplicationController
    before '/*' do
      protected!
    end

    get '/feed' do
      title = "Hirundo - Feed"
      haml :feed, locals: { title: title }
    end

    post '/feed' do
      content  = params[:content]
      location = params[:location]
      user     = User.find_by_username(session[:username])

      message  = Message.new(content, location, user)
      if message.valid?
        message.save

        set_success 'The message was successfully shared.'
      else
        set_error message.errors.messages
      end

      redirect '/feed'
    end

    helpers ViewHelpers
  end
end
