# frozen_string_literal: true

module ApplicationHelper
  ##
  # Translates a flash message key into a Bulma-friendly
  # is-class variable
  #
  # @see https://bulma.io/documentation/elements/notification/
  #
  def bulma_flash_class(key)
    if key == :error
      return :danger
    end

    key
  end
end
