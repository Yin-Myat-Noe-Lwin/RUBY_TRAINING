class AccessController < ApplicationController
  
  def home

    @username = cookies[:username]

  end

  def new
  end

  def create

    cookies[:username] = { value: params[:username]  , expires: Time.now + 60.seconds }

    cookies[:email] = { value: params[:email]  , expires: Time.now + 60.seconds }
    
    redirect_to root_url

  end

  def destroy

    cookies.delete :username

    cookies.delete :email

    redirect_to root_url

  end

end