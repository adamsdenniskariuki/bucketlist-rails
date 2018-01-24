class UserMailer < ApplicationMailer

  def reset_password_mailer(user)
    mail(
      to: @user.email,
      subject: 'Reset your password'
    )
  end

end
