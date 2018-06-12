class AttendancesController < ApplicationController
	def new
		@attendance = Attendance.new
	end

	def create 
		@attendance = Attendance.new
		card_id = params[:card_id]

		@student = Student.find_by(card_id: card_id)
# Time.now.strftime("%Y/%m/%d")

		if(@student)
			@attendance.student = @student
			# @attendance.event_id = @student
			@attendance.start_time = Date.today
			@attendance.save!
			# @attendance.end_time		
		else
		    flash[:error] = flash[:error] = "此卡號無法識別"
		    redirect_to new_attendance_path
		end	

	end 	
end
