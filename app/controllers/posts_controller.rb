# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'Created the post successfully!'
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update; end

  def destroy; end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
