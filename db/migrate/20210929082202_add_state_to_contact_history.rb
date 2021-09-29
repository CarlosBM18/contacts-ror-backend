class AddStateToContactHistory < ActiveRecord::Migration[6.1]
  def change
    add_column :contact_histories, :state, :string
  end
end
