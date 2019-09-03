# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggables, dependent: :destroy

  before_save :downcase_name

  private

  def downcase_name
    name.downcase!
  end
end
