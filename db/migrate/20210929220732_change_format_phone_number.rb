class ChangeFormatPhoneNumber < ActiveRecord::Migration[6.1]
  def change
    change_column :contacts, :phone_number, 'integer USING CAST(phone_number AS integer)'
    change_column :contact_histories, :phone_number, 'integer USING CAST(phone_number AS integer)'
  end
end
