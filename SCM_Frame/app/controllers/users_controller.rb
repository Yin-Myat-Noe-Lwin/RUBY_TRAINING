class UsersController < ApplicationController

  require 'rubygems'

  require 'csv'

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

      @upload = params[:user][:userProfile]

    if (@upload)

      File.open( Rails.root.join('app/assets', 'images', @upload.original_filename), 'wb') do |file|
                
      file.write( @upload.read )

      @user.userProfile =  @upload.original_filename
        
      end

    end


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

  def export

  begin

    @exportFile = "#{Rails.root}/public/#{rand(1..100000)}.csv"

    @users = User.order(:name)

    @headers = ["User ID", "Name", "Email", "User Type", "Phone","Address","Date of Birth"]

    CSV.open(@exportFile, 'w', write_headers: true, headers: @headers) do |writer|
    
    @users.each do |user| 
    
      writer << [user.id, user.name, user.email,user.userType,user.phone,user.address,user.dob] 
    
    end

    flash.notice = "Export Successful"

  rescue Exception=>e

    flash.alert = "Something went wrong"

    redirect_to users_url

  end

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

    flash.alert = e

    redirect_to users_url

  end

  end

  private 

  def user_params

   params.require(:user).permit(:name, :email, :password , :userProfile , :userType ,:phone, :address, :dob, :create_user_id, :updated_user_id, :deleted_user_id, :deleted_at)
  
  end

end