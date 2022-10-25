class CsvImportUsersService

  require 'csv'

  def call(file)

    @file = File.open(file)

    @csv = CSV.parse(@file, headers: true)

    @csv.each do |row|

      @user_hash = {}

      @user_hash[:name] = row['name']

      @user_hash[:email] = row['email']

      @user_hash[:userType] = row['userType']

      @user_hash[:phone] = row['phone']

      @user_hash[:address] = row['address']

      @user_hash[:dob] = row['dob']

      @user_hash[:create_user_id] = row['create_user_id']

      @user_hash[:updated_user_id] = row['updated_user_id']

      @user_hash[:deleted_user_id] = row['deleted_user_id']

      @user_hash[:created_at] = row['created_at']

      @user_hash[:updated_at] = row['updated_at']

      @user_hash[:deleted_at] = row['deleted_at']

      @user_hash[:remember_token] = (row['remember_token']= SecureRandom.urlsafe_base64) if row['remember_token'].nil?
     
      @user_hash[:userProfile] = row['userProfile']

      @user_hash[:password] = row['password']

      @user_hash[:password_confirmation] = row['password_confirmation']

      User.find_or_create_by!(@user_hash)

    end

  end
  
end