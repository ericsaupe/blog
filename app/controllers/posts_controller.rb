# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_post, only: %i[show edit update]
  before_action :authorize_post, only: %i[show edit update]

  def index
    @posts = Post.all
    authorize @posts
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    # Use strong params and merge current user as the author
    clean_params = post_params
    clean_params.merge!(author: current_user)

    @post = Post.new(clean_params)
    authorize @post

    if @post.save
      flash[:success] = 'Created the post successfully!'
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = 'Updated the post successfully!'
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(slug: params[:id])
    authorize @post

    @post&.destroy
    if @post.nil? || @post.destroyed?
      flash[:success] = 'Deleted the post successfully!'
      redirect_to root_path
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      redirect_to edit_post_path(@post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  ##
  # Sets the @post variables based on the :id param
  #
  def set_post
    @post = Post.friendly.find(params[:id])
  end

  ##
  # Authorizes via Pundit the post
  #
  def authorize_post
    authorize @post
  end
end
