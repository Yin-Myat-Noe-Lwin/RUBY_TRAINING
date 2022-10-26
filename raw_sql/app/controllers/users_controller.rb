class UsersController < ApplicationController

  require 'rubygems'

  require 'csv'

  def index

    @add = 0

    if logged_in?

      @sql1 = "SELECT * FROM users "

      @users = ActiveRecord::Base.connection.execute(@sql1)

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

      @name = params[:user][:name]

      @email = params[:user][:email]
    
      @userType = params[:user][:userType]
    
      @phone = params[:user][:phone]
    
      @address = params[:user][:address]
    
      @dob = params[:user][:dob]

      @created_at = DateTime.now

      @updated_at = DateTime.now

      @deleted_at = DateTime.now

      @create_user_id = params[:user][:create_user_id]

      @updated_user_id = 1

      @delet_user_id = 1

      @remember_token =  SecureRandom.urlsafe_base64
    
      @userProfile = params[:user][:userProfile]  

      @password = params[:user][:password]

      @password_confirmation = params[:user][:password_confirmation]

      File.open( Rails.root.join('app/assets', 'images', @userProfile.original_filename), 'wb') do |file|
                  
      file.write( @userProfile.read )

      @userProfile =  @userProfile.original_filename

      end

      @create_sql = "INSERT INTO users 
                    (name, email, userType,phone, address, dob, create_user_id, updated_user_id,deleted_user_id,created_at, updated_at, deleted_at, remember_token, userProfile ,password, password_confirmation) VALUES 
                    ('#{@name}', '#{@email}', '#{@userType}', '#{@phone}', '#{@address}', '#{@dob}', '#{@create_user_id}' , '#{@updated_user_id}', '#{@delet_user_id}', '#{@created_at}', '#{@updated_at}','#{@deleted_at}' , '#{@remember_token}', '#{@userProfile}','#{@password}' , '#{@password_confirmation}' )"

      @user = ActiveRecord::Base.connection.execute(@create_sql)

      flash.notice = "User Created"

      redirect_to users_path

    else

      flash.alert = "Please login"

      render 'board'

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

      @user_id = params[:id]

      @delete_sql = "DELETE FROM users WHERE id = #{@user_id}"

      ActiveRecord::Base.connection.execute(@delete_sql)

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

  private 

  def user_params

   params.require(:user).permit(:name, :email, :password , :password_confirmation, :userProfile , :userType ,:phone, :address, :dob, :create_user_id, :updated_user_id, :deleted_user_id, :deleted_at)
  
  end

end