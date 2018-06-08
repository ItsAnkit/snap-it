class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = current_user.posts.all
  end

  def new
    #@post = Post.new
    @post = current_user.posts.build
  end

  def create
    #if @post = Post.create(post_params)
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created..."
      redirect_to posts_path
    else
      flash[:alert] = "Your post couldn't be created. Check it out!!!"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Update successful..."
      redirect_to post_path(@post)
    else
      flash[:alert] = "Update failed!!!. Try it again."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def get_post
    @post = Post.find(params[:id])
  end

  def owned_post
    if @post.user != current_user
      flash[:alert] = 'You aren\'t legit to edit it.'
      redirect_to root_path
    end
  end
end
