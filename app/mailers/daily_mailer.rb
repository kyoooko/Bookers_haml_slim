class DailyMailer < ApplicationMailer
  def daily_mail
    @all_users = User.all
    @users = User.pluck(:email)
    mail(subject: "COMPLETE join your address to Bookers!!", to: @users)
    end
end
