class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = fetch_posts
  end

  def feed
    @posts = Post.where(user_id: current_user.followed_users.pluck(:id)).order("created_at DESC")
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, status: :see_other
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def fetch_posts
      posts = Post.all.order("created_at DESC")
      if params[:search].present?
        posts.where("description LIKE ?", "%#{params[:search]}%")
      else
        posts
      end
    end

    def post_params
      params.require(:post).permit(:title, :description, :image, :license)
    end
end
