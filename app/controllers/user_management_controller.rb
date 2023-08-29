class UserManagementController < ApplicationController
  def index
    @users = User.all
    @sellers = Seller.all
    role = current_user.role
  end
end
