class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[edit update show destroy]
  def index
    @posts = Post.all
  end

  def show; end
    
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
      redirect_to admin_posts_path
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
      redirect_to admin_post_path(@post)
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

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :start_time)
  end
end
