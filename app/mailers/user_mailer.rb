class UserMailer < ActionMailer::Base
  default from: "healthpriorityltd@gmail.com"

  def welcome_email(user_mail)
    puts "welcome mail!"
    mail(to: user_mail, subject: 'Welcome to My Awesome Site')
  end
end
