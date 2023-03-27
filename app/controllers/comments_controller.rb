class CommentsController < ApplicationController
  def create 
    @post = Post.find(params[:post_id])
    #投稿に紐づいたコメントを作成
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment_post = @comment.post
    if @comment.save
      #通知の作成
      @comment_post.create_notification_comment!(current_user, @comment.id)
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end  
