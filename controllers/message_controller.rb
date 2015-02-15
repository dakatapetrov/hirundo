module Hirundo
  class MessageController < ApplicationController
    before '/*' do
      protected!
    end

    get '/feed' do
      title = "Hirundo - Feed"

      current_user = User.find_by_username(session[:username])
      messages = Message.find_by_followers(current_user.follows)

      haml :feed, locals: { title: title, messages: messages }
    end

    post '/feed' do
      content  = params[:content]
      location = params[:location]
      user     = get_current_user

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

      haml :latest, locals: {
        title: 'Latest Messages',
        messages: messages,
        followed: get_followed
      }
    end

    get '/new.json' do
      redirect '/messages/latest' unless request.xhr?
      content_type :json

      messages = Message.find_latest_in_period.reverse
      messages_json = JSON.parse(messages.to_json)

      messages.each_with_index do |message, index|
        username = message.user.username
        messages_json[index].merge!(username: username)
      end

      messages_json.to_json
    end

    get '/hashtag/*' do |tags|
      tags = tags.split('/')
      messages = Message.find_by_tags(tags)

      haml :latest, locals: {
        title: 'Filtered Messages',
        messages: messages,
        tags: true,
        followed: get_followed
      }
    end

    helpers ViewHelpers
  end
end
