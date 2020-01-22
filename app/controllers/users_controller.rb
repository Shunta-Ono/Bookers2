class UsersController < ApplicationController

  def top
  end

  before_action :authenticate_user!, only: [:index,:show,:new,:edit,:create,:update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
    @book = Book.new
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to users_path(@user.id)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      user = User.find(params[:id])
      render :edit
    end
  end

  def correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
