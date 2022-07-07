class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create index show]
  def index
    @users =User.all

  end
 
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'ユーザー登録をしました'
      redirect_to root_path
    else
      flash.now[:notice] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tags_user = @user.tags.all.distinct
     # 自身に紐づいたタグを重複させず表示
    @posts = @user.posts.all.includes(:user).order(created_at: :desc)
    @study_record = @user.posts.count
  end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    redirect_to user_path(@user), success: t('defaults.message.updated', item: User.model_name.human)
  else
    flash.now['danger'] = t('defaults.message.not_updated', item: User.model_name.human)
    render :edit
  end
end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :avatar_image, :avatar_image_cache)
  end
end
