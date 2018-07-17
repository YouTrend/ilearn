class Attendance < ApplicationRecord
  belongs_to :student



  # Event.includes(course: :students).where(students:{id:5}).where("start_time > ?", Time.now)
  def self.getAttendance(student)
    self.where("student_id  = ? ", student.id).order("start_time desc")
  end
end
