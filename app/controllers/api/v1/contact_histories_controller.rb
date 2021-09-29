class Api::V1::ContactHistoriesController < ApplicationController
  before_action :set_contact, only: [:show]

  # POST /contact_histroies
  def create
    @contact_history = ContactHistory.new(contact_history_params)
    @contact_history.user_id = @user.id

    if @contact_history.save
      render json: @contact_history, status: :created
    else
      render json: @contact_history.errors, status: :unprocessable_entity
    end
  end

  # GET /contact_histroies/[id]
  def show
    if @user.id == @contact.user_id
      @contact_histories = ContactHistory.order("created_at DESC").where(contact_id: params[:id].to_i)
      render json: @contact_histories
    else
      render json: {error: "Can't show that contact history"}
    end
  end

  private

    def set_contact
      @contact = Contact.find(params[:id])
    end
    
    def contact_history_params
      params.require(:contact_history).require(:first_name)
      params.require(:contact_history).require(:last_name)
      params.require(:contact_history).require(:email)
      params.require(:contact_history).require(:phone_number)
      params.require(:contact_history).require(:state)
      params.require(:contact_history).permit(:first_name,:last_name,:email, :phone_number, :state)
    end
end
