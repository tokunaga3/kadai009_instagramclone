class ContactMailer < ApplicationMailer
  default from: 'notifications@example.com'
  def contact_mail(feed)
    @user = params[:user]
    @feed = feed
    mail to: @user.email, subject: "画像投稿されましたの確認メール"
  end
end
