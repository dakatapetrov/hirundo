module Hirundo
  class ApplicationController < Base
    not_found do
      title = 'Not found'
      haml :not_found, locals: { title: title }
    end
  end
end
