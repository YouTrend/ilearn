class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :card_id
      t.string :afts_id
      t.string :school
      t.string :grade
      t.string :identity_code
      t.datetime :birthday
      t.string :address
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_phone2
      t.string :contact_phone3
      t.string :remark
    end
  end
end
