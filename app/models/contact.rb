class Contact < ApplicationRecord
  belongs_to :user
  has_many :contact_histories, dependent: :destroy
end
