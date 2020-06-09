class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    # 中間テーブルfavoritesを新規作成（current_userに関連したFavoriteインスタンスを生成してるのですでにuser_id: current_user.idは代入されている）
    # favorite = @book.favorites.new(user_id: current_user.id)は下記と同じ
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # 非同期通信のため削除
    # redirect_to book_path(book)
  end

  def destroy
    @book = Book.find(params[:book_id])
    # 中間テーブルfavoritesに作成済みのuser_id:current_user兼book_id: @book.idをピップアップ
    # favorite = Favorite.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)は下記と同じ
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # 非同期通信のため削除
    # redirect_to book_path(book)
  end
end
