class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A(\S+)@(.+)\.(\S+)\z/ }
  has_many :contacts, dependent: :destroy
  has_many :contact_histories
end
