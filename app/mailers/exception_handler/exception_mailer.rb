# frozen_string_literal: true

module ExceptionHandler
  ##
  # Was necessary override this class because DEFAULT_FROM must be a valid address in AWS
  #
  class ExceptionMailer < ApplicationMailer
    default template_path:	'exception_handler/mailers' # => http://stackoverflow.com/a/18579046/1143732

    def new_exception(exception)
      @exception = exception
      mail to: ExceptionHandler.config.email
    end
  end
end
