class TagsController < ApplicationController
  def index
    @tags = Tag.all.includes(:post)
  end

  def show
    @tag = Tag.find(params[:id])
    # user = User.find_by(id: current_user.id)
    # @tag = user.tags.find(params[:id])
    @tag_user_posts  = @tag.posts.where(user_id: current_user.id).includes(:user).order("created_at DESC")
    # タグに紐づいた現在のユーザーのみの投稿
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to posts_path
  end
end

