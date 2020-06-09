class ThanksMailer < ApplicationMailer
  def thanks_mail(user)
    @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail(subject: "COMPLETE join your address to Bookers!!", to: @user.email)
  end
end
