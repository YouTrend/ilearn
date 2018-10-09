class Student < ApplicationRecord

	has_many :course_students
	has_many :courses, through: :course_students
	has_and_belongs_to_many :notifies
	has_many :contacts
	accepts_nested_attributes_for :contacts, allow_destroy: true

	scope :studying, -> { joins(:course).distinct }
	#scope :studying, -> { includes(:course_students).where.not(course_students:{course_id:nil})}
	scope :others, -> { includes(:course_students).where(course_students:{course_id:nil}) }

	def self.term_for(prefix)
		suggestions = where("name like ?", "%#{prefix}%")
		suggestions.limit(10).pluck(:name)
	end

	def self.get_next_afts_id()
		now = Time.now
		serial_date = (now.year-1911).to_s + sprintf('%02i', now.mon) + sprintf('%02i', now.day)
		serial_no = "01"
		last_student = Student.order("created_at").last
		if (last_student.nil?)
			return serial_date + serial_no
		end
		last_afts_id = last_student.afts_id
		if (serial_date == last_afts_id[0..6])
			serial_no = sprintf('%02i',last_afts_id[7..8].to_i + 1)
		end
		serial_date + serial_no
	end

end
