module Hirundo
  class ApplicationController < Base
    get '/' do
      redirect '/login' unless user_logged?
      redirect '/messages/feed'
    end

    not_found do
      title = 'Not found'
      haml :not_found, locals: { title: title }
    end

    helpers ApplicationHelpers
  end
end
