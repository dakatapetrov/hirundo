module Hirundo
  module WebsiteHelpers
    def user_logged?
      session[:username]
    end

    def protected!
      halt 401, (haml :unauthorized) unless user_logged?
    end
  end
end
