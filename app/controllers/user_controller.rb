class UserController < ApplicationController

    def index
        @devices = current_user.devices
    end

  
    def show
        @user = User.find(params[:id])
    end

end
