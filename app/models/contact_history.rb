class ContactHistory < ApplicationRecord
  belongs_to :contact
  belongs_to :user
  validates_presence_of :first_name,:last_name,:email, :phone_number, :state
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, numericality: { greater_than: 999, less_than: 9999999999999, only_integer: true }
end
