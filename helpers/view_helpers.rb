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
      date.strftime("%d/%m/%Y")
    end
  end
end
