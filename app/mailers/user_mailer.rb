class UserMailer < ApplicationMailer
	default from: 'help.apartment@gmail.com'
 
  def opt_email(user)
  	puts "UserMailer class email :::::::::::::::; #{user.email}"
    @user = user
    mail(to: @user.email, subject: 'OTP')
  end
end
