# frozen_string_literal: true

class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :content

  belongs_to :author, class_name: 'User', optional: true
  has_many :taggables, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggables
end
