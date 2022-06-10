class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to(user_path(current_user), notice: 'ログインしました')
    else
       flash.now[:notice] = 'ログインに失敗しました'
       render :new
    end
  end

  def destroy
    logout
    flash[:notice] = 'ログアウトしました'
    redirect_to root_path
  end
end