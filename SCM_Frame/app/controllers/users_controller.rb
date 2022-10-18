class UsersController < ApplicationController

  def index

    @add = 0

    if logged_in?

      @users = UserService.getAllUsers

    else

      redirect_to '/board'

    end

  end

  def new

    if logged_in?

      @user = User.new

    else

      redirect_to '/board'

    end

  end

  def create

    if logged_in?

      @user = User.new(user_params)

      @is_user_create = UserService.createUser(@user)

      if @is_user_create

        redirect_to users_path

      else

        render 'new'

      end

    else

      redirect_to '/board'

    end

  end

  def show

    if logged_in?

      @user = UserService.getUserByID(params[:id])

    else

      redirect_to '/board'
    
    end

  end
#
#  def edit
#
#    if logged_in?
#
#      @user = UserService.getUserByID(params[:id])
#  
#    else
#
#      redirect_to '/board'
#    
#    end
#
#  end
#
#  def update
#
#    if logged_in?
#
#      @user = UserService.getUserByID(params[:id])
#      
#      @is_user_update = UserService.updateUser(@user, update_params )
#
#      if @is_user_update
#
#        redirect_to users_path(@user)
#
#      else
#
#        flash.notice = "Something wrong"
#
#      end
#
#    else
#
#      redirect_to '/board'
#      
#    end
#
#  end

  def destroy

    if logged_in?

      @user = UserService.getUserByID(params[:id])

      UserService.destroyUser(@user)

    else

      redirect_to '/board'
      
    end

  end
  

  def home

    @user = User.new

  end

  def signup
    
    @user = User.new(user_params)
  
    @is_user_create = UserService.createUser(@user)

    if @is_user_create

      flash.notice = "Sign up Finished"

      redirect_to root_path

    else

      render 'home'
      
    end

  end

  def dashboard

  end

  def reset

  end

  def resetPassword

    @user = UserService.findByEmail(email: params[:email])

    if @user 

      if !params[:password].nil?  && !params[:password_confirmation].nil?

          @user.password = params[:password]
          
          @user.password_confirmation = params[:password_confirmation]
          
          @user.save
          
          flash.notice="Reset password successfully" 

          redirect_to root_path

      else

        flash.alert= "Please enter new password"

        render 'reset'

      end
      
    else

      flash.alert= "User not found"

      render 'reset'

    end

  end

  private 

  def user_params

    params.require(:user).permit(:name, :email, :password , :password_confirmation, :profile, :userType ,:phone, :address, :dob, :create_user_id, :updated_user_id, :deleted_user_id, :deleted_at)
  
  end

#  def update_params
#
#    params.require(:user).permit(:name, :email, :profile, :userType ,:phone, :address, :dob , :updated_user_id)
#  
#  end

end