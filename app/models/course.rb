class Course < ApplicationRecord

	has_many :course_students , :dependent => :destroy
	has_many :students, through: :course_students, :dependent => :destroy
	
	has_many :events, :dependent => :destroy

end
