class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:destroy, :update]

  # REGISTER
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      response = Hash.new 
      response['errors'] = @user.errors
      render json: response ,  status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.id == params[:id].to_i
      if @user.update(user_params)
        render json: @user
      else
        response = Hash.new 
        response['errors'] = @user.errors
        render json: response ,  status: :unprocessable_entity
      end
    else
      render json: {error: "Can't update that user"}
    end
  end

  # DELETE /users/1
  def destroy
    if @user.id == params[:id]
      @user.destroy
    else
      render json: {error: "Can't destroy that user"}
    end
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

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
