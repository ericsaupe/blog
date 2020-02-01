# frozen_string_literal: true

class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :content

  belongs_to :author, class_name: 'User', optional: true
  has_many :taggables, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggables

  ##
  # Method for defining meta-tag related data
  # @see https://github.com/kpumuk/meta-tags#using-metatags-in-view
  #
  def to_meta_tags
    {
      title: title,
      description: content.to_plain_text.truncate(300),
    }
  end

  ##
  # Helper method for displaying the author either with name or email
  #
  def display_author
    return 'Anonymous' if author.blank?

    author.name || author.email
  end
end
