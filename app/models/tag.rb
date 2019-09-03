# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggables, dependent: :destroy

  before_save :clean_name

  private

  def clean_name
    name.strip!
    name.downcase!
  end
end
