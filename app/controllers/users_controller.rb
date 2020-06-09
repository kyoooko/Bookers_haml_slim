class UsersController < ApplicationController
  # deviseのメソッド:ログインしてなかったらログイン画面に返す（URL直打ちも不可）
  before_action :authenticate_user!
  # current_user以外がedit,updateできないようにする（URL直打ちも不可）
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :follows, :followers]

  def show
    @book = Book.new
    @books = @user.books
    # binding.pry
  end

  def index
    @users = User.all
    @user = User.find_by(id: current_user.id)
    @book = Book.new
  end

  def edit
    # ensure_correct_userがあるのでset_userで問題なく、下記不要
    # @user = User.find_by(id: current_user.id)
  end

  def update
    # ensure_correct_userがあるのでset_userで問題なく、下記不要
    # @user = User.find_by(id: current_user.id)
    if @user.update(user_params)
      flash[:user_update] = ""
      redirect_to user_path(@user.id)
    else
      render :edit
   end
  end

  # フォロー機能
  def follows
  end

  def followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :postal_code, :prefecture_code, :city, :street)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user.id)
    end
  end
end
