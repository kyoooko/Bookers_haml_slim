class BooksController < ApplicationController
  # deviseのメソッド:ログインしてなかったらログイン画面に返す（URL直打ちも不可）
  before_action :authenticate_user!
  # current_user以外がedit,updateできないようにする（URL直打ちも不可）
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find_by(id: current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    # binding.pry
    @book.user_id = current_user.id
    if @book.save
      flash[:create] = ""
      redirect_to book_path(@book.id)
    else
      @user = User.find_by(id: current_user.id)
      @books = Book.all
      flash.now[:alert_create] = ""
      render :index
    end
  end

  def show
    @create_book = Book.new
    @book_comment = BookComment.new
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:book_update] = ""
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    if current_user.id != @book.user_id
      redirect_to books_path
    end
  end
end
