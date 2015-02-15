module Hirundo
  module ApplicationHelpers
    def set_error(message)
      flash[:errors] = message
    end

    def set_success(message)
      flash[:success] = message
    end

    def redirect_home
      redirect '/'
    end

    def user_logged?
      session[:username]
    end

    def protected!
      halt 401, (redirect '/login') unless user_logged?
    end

    def get_current_user
      User.find_by_username(session[:username])
    end

    def get_followed
      get_current_user.follows.map(&:username)
    end
  end
end
