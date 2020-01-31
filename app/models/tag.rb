# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggables, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false }

  before_validation :clean_name

  private

  def clean_name
    name.strip!
  end
end
