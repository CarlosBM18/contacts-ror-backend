class AddUserToContactsHistory < ActiveRecord::Migration[6.1]
  def change
    add_reference :contact_histories, :user, null: false, foreign_key: true
  end
end
