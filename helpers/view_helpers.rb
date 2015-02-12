module Hirundo
  module ViewHelpers
    def show_error_message(error)
      inner = case error
              when String
                "<p>#{error}</p>"
              when Hash
                error.values.inject("") { |memo, value| memo += "<p>#{value.inject("") { |m, v| m += v }}</p>" }
              else
              end

      p error
      p inner
      puts error.class

      "<div class='center-block alert alert-danger'>#{inner}</div>" if error
    end

    def show_success_message(success)
      "<div class='center-block alert alert-success'><span>#{success}</span></div>" if success
    end

    def date_to_string(date)
      date.strftime("%d/%m/%Y")
    end
  end
end
