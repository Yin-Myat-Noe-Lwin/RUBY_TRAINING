class SessionsController < ApplicationController

  def board

  end

  def create

    @user = UserService.findByEmail(email: params[:session][:email])

    if @user  && (@user.password == params[:session][:password])

      session[:user_id] = @user.id
      
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)

      flash.notice="Login successful" 

      redirect_to root_path 

    else

      flash.alert = "User not found"

      render 'board'

    end  
    
  end

  def destroy
  
    forget(current_user)

    session.delete(:user_id)

    @current_user = nil

    flash.notice="Logged out"
    
    redirect_to root_path

  end

end