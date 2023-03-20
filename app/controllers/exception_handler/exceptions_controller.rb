# frozen_string_literal: true

module ExceptionHandler
  ##
  # Original method show was override because API doesn't allow views
  #
  class ExceptionsController < ApplicationController
    respond_to :html, :js, :json, :xml
    before_action { |e| @exception = ExceptionHandler::Exception.new(request: e.request) }

    def show
      @main = { error: "Details sent to #{ExceptionHandler.config.email}" }
      render json: @main, status: @exception.status
    end
  end
end
