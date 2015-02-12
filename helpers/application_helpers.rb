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
  end
end
