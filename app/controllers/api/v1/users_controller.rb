class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:destroy, :update, :show]
  before_action :authenticated_user, only: [:update, :destroy, :show]

  # REGISTER
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      response = Hash.new 
      response['errors'] = @user.errors
      render json: response, status: :unprocessable_entity
    end
  end

  def show
    render json: @user, status: :ok
  end

  # DELETE /users/1
  def destroy
    return render status: :forbidden unless @user.destroy
    render status: :ok
  end

  # LOGGING IN
  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      response = Hash.new
      response['errors'] = {"invalid":["email or password"]}
      render json: response ,  status: :unprocessable_entity
    end
  end

  private

    def authenticated_user
      render json: response , status: :forbidden unless @user.id == params[:id].to_i
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
