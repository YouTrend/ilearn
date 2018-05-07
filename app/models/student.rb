class Student < ApplicationRecord

	has_many :course_students
	has_many :courses, through: :course_students

	scope :studying, -> { joins(:courses) }
	scope :others, -> { includes(:course_students).where(course_students:{course_id:nil}) }

end
