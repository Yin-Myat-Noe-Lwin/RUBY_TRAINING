class UserMailer < ApplicationMailer

  default from: "yinmyatnoelwin1@gmail.com"


  def signup_confirmation(user)

    @user = user

    mail to: user.email, subject: "Sign Up Confirmation"
    
  end
  
end
