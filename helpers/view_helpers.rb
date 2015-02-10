module Hirundo
  module ViewHelpers
    def show_error_message(error)
      inner = case error
              when String
                puts "string"
                "<p>#{error}</p>"
              when Hash
                puts "hash"
                error.values.inject("") { |memo, value| memo += "<p>#{value.first}</p>" }
              else
                puts "else"
              end

      p error
      p inner
      puts error.class

      "<div class='alert alert-danger'>#{inner}</div>" if error
    end

    def show_success_message(success)
      "<div class='alert alert-success'><span>#{success}</span></div>" if success
    end

    def date_to_string(date)
      date.strftime("%d/%m/%Y")
    end
  end
end
