# frozen_string_literal: true

class Post < ApplicationRecord
  has_rich_text :content

  belongs_to :author, class_name: 'User', optional: true
end
