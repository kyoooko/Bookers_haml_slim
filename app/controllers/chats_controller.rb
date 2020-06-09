class ChatsController < ApplicationController
  def show
    # ひろし（相手）
    @user = User.find(params[:id])
    # current_user(みさえ)のuser_rooms中間テーブルを全て取り出しpluckメソッドで:room_idを配列にしたものがroom（.user_roomsはアソシエーションのつなぎ方。）この時点ではひろし以外の人の中間テーブルuser_roomsも含まれる
    rooms = current_user.user_rooms.pluck(:room_id)
    # user_id:がひろしでroom_idが roomsのもの（みさえとの部屋）を取り出す（これがみさえとひろしの部屋）
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    # みさえとひろしの部屋が既にあれば@room に既にあるroomを代入（user_rooms.roomはアソシエーションのつなぎ方）
    if user_rooms.nil?
      # みさえとひろしの部屋がまだなければ新たに作理保存。同時に中間テーブルをみさえ用とひろし用にそれぞれ作る
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
    # room.chatsはアソシエーションのつなぎ方。@chatsはみさえとひろしの部屋のchatの全て
    @chats = @room.chats
    # この部屋で新規作成するchat
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    # みさえが入力、新規投稿したchatを保存（current_user.chatsはアソシエーションのつなぎ方）
    @chat = current_user.chats.new(chat_params)
    @chat.save
  end

  private

  # messageとroom_idカラムの内容を受け取る
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
