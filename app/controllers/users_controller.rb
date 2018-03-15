class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    add_breadcrumb 'Users'
  end

  def show
    @user = User.find(params[:id])
    add_breadcrumb 'Users', users_path
    add_breadcrumb @user.name
  end
end
