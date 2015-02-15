module Hirundo
  class UserController < ApplicationController
    before '/*' do
      protected!
    end

    get '/profile/:username' do
      user     = User.find_by_username(params[:username])
      messages = Message.find_by_user(user)

      haml :profile, locals: {
        title: 'Profile',
        user: user,
        messages: messages,
        followed: get_followed
      }
    end

    get '/follow/:username' do
      current_user   = get_current_user
      user_to_follow = User.find_by_username(params[:username])

      current_user.follows.push(user_to_follow)

      redirect '/user/profile/' + session[:username]
    end

    get '/unfollow/:username' do
      current_user     = get_current_user
      user_to_unfollow = User.find_by_username(params[:username])

      begin
        current_user.pull(follows: user_to_unfollow)
      rescue
      end

      redirect '/user/profile/' + session[:username]
    end

    helpers ViewHelpers
  end
end
