class Contact < ApplicationRecord
  belongs_to :user
  has_many :contact_histories, dependent: :destroy
  validates_presence_of :first_name, :last_name, :email, :phone_number
  validates :email, uniqueness: { scope: :user_id }, format: { with: /\A(\S+)@(.+)\.(\S+)\z/ }
  validates :phone_number, numericality: { only_integer: true }
end
