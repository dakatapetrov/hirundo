module Hirundo
  module ViewHelpers
    def show_error_message
      "<p class='lead text-danger spacer'>#{@error}</p>" if @error
    end

    def show_success_message
      "<p class='lead text-success spacer'>#{@success}</p>" if @success
    end

    def date_to_string(date)
      date.strftime("%d/%m/%Y")
    end
  end
end
