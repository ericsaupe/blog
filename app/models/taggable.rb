# frozen_string_literal: true

class Taggable < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  # Delegate method calls to taggable
  delegate :title, :display_author, :tags, :content, to: :taggable
end
