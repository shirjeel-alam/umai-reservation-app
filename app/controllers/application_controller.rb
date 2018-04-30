class ApplicationController < ActionController::Base
  include ExceptionHandler

  before_action :set_default_request_format

  def set_default_request_format
    request.format = :json unless params[:format]
  end
end
