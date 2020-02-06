# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggables, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false }

  before_validation :clean_name

  ##
  # Method for defining meta-tag related data
  # @see https://github.com/kpumuk/meta-tags#using-metatags-in-view
  #
  def to_meta_tags
    {
      title: name
    }
  end

  private

  def clean_name
    name.strip!
  end
end
