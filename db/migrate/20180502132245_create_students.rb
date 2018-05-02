class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string "afts_id", null: false
      t.string "name"
      t.string "card_id"
      t.string "school"
      t.string "grade"
      t.integer "user_id"
      

      t.timestamps

    end

      add_index :students, :afts_id, unique: true
  end
end
