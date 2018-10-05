class AddContactColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :phone2, :string
    add_column :contacts, :phone3, :string
  end
end
