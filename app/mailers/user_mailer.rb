class UserMailer < ActionMailer::Base
  default from: 'healthpriorityltd@gmail.com'

  def welcome_email(user_mail)
    mail(to: user_mail, subject: 'Welcome to HealthPriority!')
  end

  def send_message(user_name, user_mail, mail_subject, mail_body)
    mail(from: "#{user_name}<#{user_mail}>", to: 'drakstur@gmail.com', subject: mail_subject, body: mail_body)
  end

end
