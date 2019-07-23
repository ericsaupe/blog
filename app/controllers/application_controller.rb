# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout :layout_by_resource

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
end
