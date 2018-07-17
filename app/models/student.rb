class Student < ApplicationRecord

	has_many :course_students
	has_many :courses, through: :course_students
	has_many :contacts
	accepts_nested_attributes_for :contacts, allow_destroy: true
	 
	# scope :studying, -> { joins(:courses) }
	scope :studying, -> { includes(:course_students).where.not(course_students:{course_id:nil})}
	scope :others, -> { includes(:course_students).where(course_students:{course_id:nil}) }

	def self.term_for(prefix)
		suggestions = where("name like ?", "%#{prefix}%")
		suggestions.limit(10).pluck(:name)
	end

end
