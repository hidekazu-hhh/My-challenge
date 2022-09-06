class TagsController < ApplicationController
  def index
    @tags = Tag.all.includes(:post)
  end

  def show
    @tag = Tag.find(params[:id])
    # user = User.find_by(id: current_user.id)
    # @tag = user.tags.find(params[:id])

    @tag_user_posts  = @tag.posts.includes(:user).order("created_at DESC").page(params[:page])
   
   # タグに紐づいた現在のユーザーのみの投稿
    # @tag_user_posts  = @tag.posts.where(user_id: current_user.id).includes(:user).order("created_at DESC")
   
    # @count_post =  @tag.posts.where(user_id: current_user.id).includes(:user).order("created_at DESC").count
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to posts_path
  end
end

