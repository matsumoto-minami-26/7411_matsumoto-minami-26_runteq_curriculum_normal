class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to root_path, notice: 'Login successful'
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    redirect_back_or_to root_path, notice: 'Logged out!'
  end

  private
  def session_params
    params.require(:user).permit(:last_name, :first_name, :email, :password, :password_confirmation)
  end
end
