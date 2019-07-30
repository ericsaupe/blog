# frozen_string_literal: true

module ApplicationHelper
  ##
  # Translates a flash message key into a Bulma-friendly
  # is-class variable
  #
  # @see https://bulma.io/documentation/elements/notification/
  #
  def bulma_flash_class(key)
    key = key.to_sym # Ensure we are working with a symbol
    
    if key == :error
      return :danger
    elsif key == :notice
      return :success
    end

    key
  end
end
