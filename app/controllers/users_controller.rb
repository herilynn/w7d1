class UsersController < ApplicationController


    def new 

        @user = User.new

        render :new 

    end 


    def create 

        @user = User.new(user_params)     #User.new invokes a setter for password +username bc they are being called

        if @user.save!
            login!(@user)
            redirect_to user_url(@user) #why do you pass in user to this?

        else 
            render :new
        end 


    end 


private

def user_params
    params.require(:user).permit(:username, :password_digest, :session_token)

end 