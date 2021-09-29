class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:destroy, :update]

  # REGISTER
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.to_json(only: [:id, :email]), status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.id == params[:id].to_i
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: {error: "Can't update that user"}, status :unauthorized
    end
  end

  # DELETE /users/1
  def destroy
    if @user.id == params[:id]
      @user.destroy
    else
      render json: {error: "Can't destroy that user"}, status :unauthorized
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid email or password"}, status: 400
    end
  end

  private
  
    def user_params
      params.require(:user).require(:email)
      params.require(:user).require(:password)
      params.require(:user).permit(:email, :password)
    end
end
