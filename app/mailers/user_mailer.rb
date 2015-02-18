class UserMailer < ActionMailer::Base
  default from: 'healthpriorityltd@gmail.com'

  def welcome_email(user_mail)
    mail(to: user_mail, subject: 'Welcome to HealthPriority!')
  end

  def send_message(user_name, user_mail, mail_subject, mail_body, mail_phone)
    body_html = "<!DOCTYPE html>
                  <html>
                    <head>
                      <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
                    </head>
                    <body>
                      <div>Mail from: #{user_name}<#{user_mail}></div><br/>
                      <div>Phone: #{mail_phone}</div><br/>
                      <div>Subject: #{mail_subject}</div><br/>
                      <div>Text: #{mail_body}</div>
                    </body>
                  </html>"

    mail(from: "#{user_name}<#{user_mail}>", to: 'healthpriorityltd@gmail.com', subject: mail_subject, body: body_html, content_type: 'text/html')
  end

end
