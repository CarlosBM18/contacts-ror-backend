class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_many :contacts
  has_many :contact_histories, through: :contacts
  
end
