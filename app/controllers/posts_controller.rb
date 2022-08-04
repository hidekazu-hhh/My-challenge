class PostsController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts =@q.result(distinct: true).includes(%i[user tags]).order(created_at: :desc).page(params[:page])
    @tags = current_user.tags.all
  end

  def show
    @post = Post.find(params[:id])
    
  end

  def new
    @post = Post.new
  end

  def create
    # パラメーターを受け取り保存準備
    @post = current_user.posts.new(post_params)   
    if @post.save
      # タグの保存
      @post.save_tags(params[:post][:tag])
      # 成功したらトップページへリダイレクト
      redirect_to posts_path
    else
      # 失敗した場合は、newへ戻る
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      # タグの更新
      @post.save_tags(params[:post][:tag])
      # 成功したら投稿記事へリダイレクト
      redirect_to post_path(@post)
    else
      # 失敗した場合は、editへ戻る
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).destroy()
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:content, :start_time)
    # params.require(:post).permit(:content, :start_time, tag: {}).merge(tag: params[:name])
  end
end

