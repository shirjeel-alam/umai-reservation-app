class ApplicationController < ActionController::Base
  include ExceptionHandler

  def set_default_request_format
    request.format = :json unless params[:format]
  end
end
