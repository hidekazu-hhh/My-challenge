class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]
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
    @tags_user_tag = @user.tags.group(:name).count
     # 自身に紐づいたタグを重複させず表示
     @q = @user.posts.all.ransack(params[:q])
     @posts = @q.result(distinct: true).includes(%i[user tags]).order(created_at: :desc).page(params[:page])
    @study_record = @user.tags.count
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    redirect_to user_path(@user)
  else
    flash.now['danger'] = t('defaults.message.not_updated', item: User.model_name.human)
    render :edit
  end
end

def destroy
  @user = User.find(params[:id])
  @user.destroy!
  redirect_to root_path, notice: '退会しました。'
end

def follows
  user = User.find(params[:id])
  @users = user.following_user.page(params[:page]).per(3).reverse_order
end

def followers
  user = User.find(params[:id])
  @users = user.follower_user.page(params[:page]).per(3).reverse_order
end


def  calendar
  @user = User.find(params[:id])
  @month_record =@user.posts.group("MONTH(start_time)")
  @q = @user.posts.all.ransack(params[:q])
  @posts = @q.result(distinct: true).includes(%i[user tags]).order(created_at: :desc).page(params[:page])
end

def chart
  @user = User.find(params[:id])
  @chart =@user.tags.group(:name).order('count_name desc').count(:name)
  @tags_user_tag = @user.tags.group(:name).order('count_name desc').count(:name)
  @study_record = @user.tags.count
  @month_record =@user.posts.group("MONTH(created_at)").count
  @year_record =@user.posts.group("YEAR(created_at)").count
  @week_record =@user.posts.group("WEEK(created_at)").count
end

def column_chart
  @user = User.find(params[:id])
  @chart =@user.tags.group(:name).order('count_name desc').count(:name)
  @tags_user_tag = @user.tags.group(:name).order('count_name desc').count(:name)
  @study_record = @user.tags.count
  @month_record =@user.posts.group("MONTH(created_at)").count
 
end
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :avatar_image, :avatar_image_cache)
  end
end
