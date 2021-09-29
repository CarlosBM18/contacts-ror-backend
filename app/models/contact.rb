class Contact < ApplicationRecord
  belongs_to :user
  has_many :contacts_history
end
