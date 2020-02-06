# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_tag, only: %i[show]

  def show
    @posts = @tag.taggables.order(created_at: :desc).page(params[:page])
    authorize @posts
  end

  private

  ##
  # Sets the @tag variables based on the :id param
  #
  def set_tag
    @tag = Tag.find_by!(name: CGI.unescape(params[:id]))
    set_meta_tags @tag
  end
end
