module Hirundo
  module ViewHelpers
    def show_message(message, type)
      "<div class='center-block alert alert-#{type}'>#{message}</div>" if message
    end

    def show_error_messages
      errors = flash[:errors]

      message = case errors
                when String
                  errors
                when Hash
                  errors.values.inject("") do |memo, value|
                    messages = value.inject("") { |mem, msg| mem += msg }
                    memo += "<p>#{messages}</p>"
                  end
                end

      show_message(message, 'danger')
    end

    def show_success_messages
      show_message(flash[:success], 'success')
    end

    def date_to_string(date)
      date.strftime("%d/%m/%Y %H:%M:%S")
    end

    def print_message_content(message)
      content = message.content
      if message.tags
        message.tags.each do |tag|
          content.gsub!("##{tag}", "<a href=/messages/hashtag/#{tag}>##{tag}</a>")
        end
      end

      content
    end

    def followed?(username, followed)
      followed.include? username
    end

    def print_username(username, followed)
      string = ''
      if followed?(username, followed)
        string += '<span class="glyphicon glyphicon-star" aria-hidden="true"></span>'
      end

      string += '<a href="/user/profile/' + username + '">' + username + '</a>'
    end

    def minutes_in_words(timestamp)
      minutes = ((Time.now - timestamp).abs).round

      return nil if minutes < 0

      case minutes
      when 0..60           then "#{minutes} secs ago"
      when 60..3599        then "#{minutes/60} mins ago"
      when 3600..86399     then "#{minutes/60/60} hrs ago"
      when 86400..691140   then "#{minutes/86400} days ago"
      end
    end
  end
end
