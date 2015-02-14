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

      redirect '/messages/feed'
    end

    get '/latest' do
      messages = Message.find_latest
      haml :latest, { locals: { title: 'Latest Messages', messages: messages } }
    end

    get '/hashtag/*' do |tags|
      tags = tags.split('/')
      messages = Message.find_by_tags(tags)
      haml :latest, { locals: { title: 'Filtered Messages', messages: messages, tags: true } }
    end

    helpers ViewHelpers
  end
end
