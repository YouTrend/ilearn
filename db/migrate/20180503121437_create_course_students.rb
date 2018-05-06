class CreateCourseStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :course_students do |t|
      t.references :courses, foreign_key: true
      t.references :students, foreign_key: true

      t.timestamps
    end
  end
end
