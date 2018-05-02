class Course < ApplicationRecord

	def index 
		@courses = Course.all 
	end	
end
