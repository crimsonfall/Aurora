class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_or_initialize_by(user: current_user)

    if @like.new_record?
      @like.save
    else
      @like.destroy
    end

    redirect_to params[:redirect_to] || posts_path
  end
end
