class PostsController < ApplicationController
  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  def like
    @post = Post.find(params[:id])

    if current_user.liked_posts.include?(@post)
      @post.likes.find_by(user_id: current_user.id).destroy
      @liked = false
    else
      @post.likes.create(user: current_user)
      @liked = true
    end

    respond_to do |format|
      format.html { redirect_to @post }
      format.json { render json: { like_count: @post.likes.count, liked: @liked } }
  end

  end

  private

    def post_params
      params.require(:post).permit(:title, :description, :image)
    end
end
