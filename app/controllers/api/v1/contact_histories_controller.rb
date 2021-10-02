class Api::V1::ContactHistoriesController < ApplicationController
  before_action :set_contact, only: [:show]
  before_action :check_user_contact, only: [:show, :create]
 
  # POST /contact_histories
  def create
    @contact_history = ContactHistory.new(contact_history_params)
    @contact_history.user_id = @user.id

    if @contact_history.save
      render json: @contact_history, status: :created
    else
      render json: @contact_history.errors, status: :bad_request
    end
  end

  # GET /contact_histories/[id]
  def show
    @contact_histories = ContactHistory.order("created_at DESC").where(contact_id: params[:id].to_i)
    render json: @contact_histories, status: :ok
  end

  private
    def check_user_contact
      render json: response , status: :forbidden unless @user.id == @contact.user_id
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end
    
    def contact_history_params
      params.require(:contact_history).permit(:first_name,:last_name,:email, :phone_number, :state)
    end
end
