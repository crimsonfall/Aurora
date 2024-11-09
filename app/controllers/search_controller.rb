class SearchController < ApplicationController
  def index
    if params[:query].present?
      @posts = Post.search(params[:query]).order("created_at DESC")
    else
      @posts = Post.none
    end
  end
end
