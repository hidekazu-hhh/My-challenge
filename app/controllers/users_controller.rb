class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
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
    @tags_user = current_user.tags.all.distinct
     # 自身に紐づいたタグを重複させず表示
    @user = User.find(params[:id])
   
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
