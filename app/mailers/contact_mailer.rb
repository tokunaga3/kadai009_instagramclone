class ContactMailer < ApplicationMailer
  default from: 'notifications@example.com'
  def contact_mail(contact)
    @contact = contact
    mail to: "@user.email", subject: "画像投稿されましたの確認メール"
  end
end

  # def contact_mail
  #   @user = params[:user]
  #   # @url  = 'http://example.com/login'
  #   mail(to: @user.email, subject: '私の素敵なサイトへようこそ')
  # end
# end
