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

    case key
    when :error
      :danger
    when :notice
      :success
    when :alert
      :warning
    else
      key
    end
  end

  ##
  # Returns a list of valid tags listed alphabetically
  #
  def tags
    Tag.order(:name)
  end
end
