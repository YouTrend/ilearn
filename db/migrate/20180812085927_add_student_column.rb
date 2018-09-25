class AddStudentColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :department_id, :integer
    add_column :students, :birthday, :datetime
    
    add_column :courses, :department_id, :integer
  end
end
