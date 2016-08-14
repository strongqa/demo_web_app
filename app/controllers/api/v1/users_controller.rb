class API::V1::UsersController < API::V1::BaseController
  respond_to :json

  def index
    if params[:email].present?
      respond_with User.where(email: params[:email])
    else
      respond_with User.all
    end
  end

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    user.confirmed_at = Time.current
    if user.save
      render json: user, status: :created , location: [:api, :v1, user]
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
