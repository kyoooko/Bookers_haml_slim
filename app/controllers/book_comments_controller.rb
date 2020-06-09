class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    # BookComment中間モデルを新規作成し、user_id:current_user兼book_id: @book.idを代入
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id

    if @comment.save
      # 非同期通信のため変更
      # redirect_to book_path(@book)
      render :index
    else
      # 非同期通信のため変更
      # redirect_to book_path(@book)
      render :index
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    if BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
      # binding.pry
      # 非同期通信のため変更
      # redirect_to book_path(params[:book_id])
      render :index
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
