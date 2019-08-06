# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  layout :layout_by_resource

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  ##
  # Prefer the application.html.erb layout unless it is a Devise
  # controller
  #
  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  ##
  # Handle a Pundit authorization failure gracefully
  #
  def user_not_authorized
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end
end
