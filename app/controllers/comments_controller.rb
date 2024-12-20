class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post
    else
      render "edit"
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(comment_params)
  end
end
