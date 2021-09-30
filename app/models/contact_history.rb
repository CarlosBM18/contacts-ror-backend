class ContactHistory < ApplicationRecord
  belongs_to :contact
  belongs_to :user
  validates_presence_of :first_name,:last_name,:email, :phone_number, :state
  validates :email, uniqueness: { scope: :user_id }, format: { with: /\A(\S+)@(.+)\.(\S+)\z/ }
  validates :phone_number, numericality: { only_integer: true }
end
