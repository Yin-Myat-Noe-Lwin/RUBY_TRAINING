class UsersController < ApplicationController

  require 'rubygems'

  require 'csv'

 

  def index

    @add = 0

    if logged_in?

      @sql1 = "SELECT * FROM users "

      @users = ActiveRecord::Base.connection.execute(@sql1)

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

      File.open( Rails.root.join('app/assets', 'images', @userProfile.original_filename), 'wb') do |file|
                
      file.write( @userProfile.read )

      @userProfile =  @userProfile.original_filename

  end

  @create_sql = "INSERT INTO users (name, email, userType, 
  phone, address, dob, create_user_id, updated_user_id,deleted_user_id,created_at, updated_at, deleted_at, remember_token,
  userProfile ,password) VALUES ('#{@name}', '#{@email}', '#{@userType}', '#{@phone}', '#{@address}', 
  '#{@dob}', '#{@create_user_id}' , '#{@updated_user_id}', '#{@delet_user_id}', '#{@created_at}', '#{@updated_at}','#{@deleted_at}' , '#{@remember_token}', '#{@userProfile}',' #{@password}')"

  @user = ActiveRecord::Base.connection.execute(@create_sql)

    flash.notice = "User Created"

    redirect_to users_path

  else

    render 'board'

  end


  def show

    if logged_in?

      @user = UserService.getUserByID(params[:id])

    else

      redirect_to '/board'
    
    end

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
