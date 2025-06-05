class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :set_frame_ancestors_header

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end

  def set_frame_ancestors_header
    response.headers['Content-Security-Policy'] = "frame-ancestors https://iframetester.com/"
  end
end
