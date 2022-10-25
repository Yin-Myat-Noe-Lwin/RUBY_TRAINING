class UsersController < ApplicationController

  require 'rubygems'

  require 'csv'

  def index

    if logged_in?

      @users = UserService.getAllUsers

      respond_to do |format|

        format.html

        format.csv { send_data @users.to_csv }

      end

    else

      flash.alert = "Please login"
    
      redirect_to '/board'
    
    end
    
  end

  def new

    if logged_in?

      @user = User.new

    else

      flash.alert = "Please login"

      redirect_to '/board'

    end

  end

  def create

    if logged_in?

      @user = User.new(user_params)

      @upload = params[:user][:userProfile]

      if (@upload)

        File.open( Rails.root.join('app/assets', 'images', @upload.original_filename), 'wb') do |file|
                  
        file.write( @upload.read )

        @user.userProfile =  @upload.original_filename
          
        end

      end

      @is_user_create = UserService.createUser(@user)

      respond_to do |format|

        @errorName = []

        @errorEmail = []

        @errorPsw = []

        @errorPswConfirm = []

        @errorPf = []

        if @is_user_create

          format.js

        else

        format.js

        @user.errors.any?

        if (@user.errors["name"] != nil)

          @errorName.push(@user.errors["name"][0])

        end

        if (@user.errors["email"] != nil)

          @errorEmail.push(@user.errors["email"][0])

        end

        if (@user.errors["password"] != nil)

          @errorPsw.push(@user.errors["password"][0])

        end
        
        if (@user.errors["password_confirmation"] != nil)

          @errorPswConfirm.push(@user.errors["password_confirmation"][0])
        end
          
        if (@user.errors["userProfile"] != nil)
          
          @errorPf.push(@user.errors["userProfile"][0])
        
        end

      end

    end

    else

      flash.alert = "Please login"

      redirect_to '/board'

    end

  end

  def show

    if logged_in?

      @user = UserService.getUserByID(params[:id])

    else

      flash.alert = "Please login"

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

      respond_to do |format|

        format.js
        
      end

    else

      flash.alert = "Please login"

      redirect_to '/board'
      
    end

  end
  

  def home

    @user = User.new

  end

  def signup

    @user = User.new(user_params)

    @upload = params[:user][:userProfile]

    if (@upload)

      File.open( Rails.root.join('app/assets', 'images', @upload.original_filename), 'wb') do |file|
                
      file.write( @upload.read )

      @user.userProfile =  @upload.original_filename
        
      end

    end

      @is_user_create = UserService.createUser(@user)

      if @is_user_create

        UserMailer.signup_confirmation(@user).deliver_now

        flash.notice="Sign up successful" 

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

    @new_password = params[:password]

    @new_password_confirm = params[:password_confirmation]

    if @user 

      if !@new_password.nil?  && !@new_password_confirm.nil? && @new_password == @new_password_confirm

        @user.password = @new_password
          
        @user.password_confirmation = @new_password_confirm
          
        @user.save
          
        flash.notice="Reset password successfully" 

        redirect_to root_path

      else

        flash.alert= "Please enter both new password and new password confirmation.(Both fields must match.)"

        render 'reset'

      end
      
    else

      flash.alert= "User not found"

      render 'reset'

    end

  end

  def formImport

  end

  def import

    begin

      @file = params[:importFile]

      CsvImportUsersService.new.call(@file)
    
      flash.notice = "Import Success"

      redirect_to users_url

    rescue Exception=>e

      flash.alert = "Something went wrong!!!"

      redirect_to users_url

    end

  end

  private 

  def user_params

   params.require(:user).permit(:name, :email, :password , :password_confirmation, :userProfile , :userType ,:phone, :address, :dob, :create_user_id, :updated_user_id, :deleted_user_id, :deleted_at)
  
  end

end