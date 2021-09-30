class Api::V1::ContactsController < ApplicationController
  # TODO: check_contact_exists
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.order("first_name ASC").where(user_id: @user.id)
    render json: @contacts
  end

  # GET /contacts/1
  def show
    if @user.id == @contact.user_id
      render json: @contact
    else
      render json: {error: "Can't show that contact"}
    end
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
      render json: response ,  status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      @contact_history = ContactHistory.new(contact_params)
      @contact_history.contact_id = @contact.id
      @contact_history.user_id = @user.id
      @contact_history.state = "updated"
      @contact_history.save
      render json: @contact
    else
      response = Hash.new 
      response['errors'] = @contact.errors
      render json: response ,  status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    if @user.id == @contact.user_id #TODO: before_action
      @contact.destroy
    else
      render json: {error: "Can't destroy that contact"}
    end
  end

  private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:first_name,:last_name,:email, :phone_number)
    end
end
