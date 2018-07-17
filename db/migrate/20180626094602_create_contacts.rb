class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone
      t.string :country_code
      t.boolean :notify_demand
      
      t.timestamps
    end
  end
end
