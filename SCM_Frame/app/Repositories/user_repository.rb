class UserRepository
  
  class << self
    
    def getAllUsers

      @users = User.all

    end

    def createUser(user)

      @is_user_create = user.save

    end

    def getUserByID(id)

      @user = User.find(id)

    end

    def updateUser(user, user_params)

      @is_update_user = user.update(user_params)

    end

    def destroyUser(user)

      user.destroy

    end

    def findByEmail(email)

      @user = User.find_by(email)
      
    end
    
  end

end