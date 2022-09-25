class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]
  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      # redirect_back_or_to(user_path(current_user), notice: 'ログインしました')
      redirect_to user_path(current_user), notice: 'ログインしました'
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

  def guest_login
    @guest_user = User.create(
    name: 'ゲスト',
    email: SecureRandom.alphanumeric(10) + "@email.com",
    role: 2,
    password: 'password',
    password_confirmation: 'password'
    )
    auto_login(@guest_user)
    redirect_to user_path(current_user), notice: 'ゲストとしてログインしました'
  end

end