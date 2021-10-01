class Api::V1::ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]
  before_action :check_user_contact, only: [:show, :update, :destroy]
  
  # GET /contacts
  def index
    @contacts = Contact.order("first_name ASC").where(user_id: @user.id)
    render json: @contacts
  end

  # GET /contacts/1
  def show
    render json: @contact
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = @user.id

    if @contact.save
      @contact_history = ContactHistory.new(contact_params)
      @contact_history.contact_id = @contact.id
      @contact_history.user_id = @user.id
      @contact_history.state = "created"
      @contact_history.save
      render json: @contact, status: :created
    else
      response = Hash.new 
      response['errors'] = @contact.errors
      render json: response ,  status: :bad_request
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      @contact_history = ContactHistory.new(contact_params)
      @contact_history.contact_id = @contact.id
      @contact_history.user_id = @user.id
      @contact_history.state = "updated"
      if @contact_history.save
        render json: @contact
      else
        response = Hash.new 
        response['errors'] = @contact_history.errors
        render json: response ,  status: :bad_request
      end
    else
      response = Hash.new 
      response['errors'] = @contact.errors
      render json: response ,  status: :bad_request
    end
  end

  # DELETE /contacts/1
  def destroy
    return render status: :internal_server_error unless @contact.destroy
    render status: :ok
  end

  private
    def check_user_contact
      render json: response , status: :forbidden unless @user.id == @contact.user_id
    end

    def set_contact
      render json: response, status: :not_found unless @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:first_name,:last_name,:email, :phone_number)
    end
end
