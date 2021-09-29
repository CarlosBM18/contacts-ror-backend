class Contact < ApplicationRecord
  belongs_to :user
  has_many :contact_histories, dependent: :destroy
  validates_presence_of :first_name, :last_name, :email, :phone_number
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { scope: :user_id }
  validates :phone_number, numericality: { greater_than: 999, less_than: 9999999999999, only_integer: true }
end
