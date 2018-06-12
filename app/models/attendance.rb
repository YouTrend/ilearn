class Attendance < ApplicationRecord
  belongs_to :student



  # Event.includes(course: :students).where(students:{id:5}).where("start_time > ?", Time.now)

end
