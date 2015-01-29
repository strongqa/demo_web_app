class API::V1::UsersController < API::V1::BaseController
  respond_to :json

  def index
    respond_with User.all
  end

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    user.confirm!
    if user.save
      render json: user, status: :create, location: [:api, :v1, user]
    else
      render json: {errors: user.errors}, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params) #TODO Net::SMTPAuthenticationError
      render json: user, status: :ok, location: [:api, :v1, user]
    else
      render json: {errors: user.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end