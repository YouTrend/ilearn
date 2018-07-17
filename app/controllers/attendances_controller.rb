class AttendancesController < ApplicationController
	def new
		@attendance = Attendance.new
		@attendance_top10 = Attendance.order("id desc").limit(10)
	end

	def create 
		card_id = params[:card_id]
		@student = Student.find_by(card_id: card_id)


		if(@student)
			if (check(@student))
			
			end
		else
		    flash[:error]  = "此卡號無法識別"
		end	
		redirect_to new_attendance_path
	end 	
	def check(student)
		@attendance_by_student = Attendance.where("student_id  = ? ", student.id).order("start_time desc")
		if (@attendance_by_student.size > 0)
			@lastAttendance = @attendance_by_student.first
			if((Time.now - @lastAttendance.start_time) / 60 > 10)
				if (@lastAttendance.end_time.nil? and (Date.today - @lastAttendance.start_time.to_date).to_i < 1)
					setFinishClass(student,@lastAttendance)
				else
					setStartClass(student)
				end
			else
				flash[:error]  = "打卡失敗，時間過近，上下課時間至少要10分鐘以上。"
			end
		else
			setStartClass(student)
		end
	end
	def setStartClass (student)
		@attendance = Attendance.new
		@attendance.student = student
		# @attendance.event_id = @student
		@attendance.start_time = Time.now
		# @attendance.end_time		
		@attendance.save
		run_line_notify(student)
	end 

	def setFinishClass (student,attendance)
		attendance.end_time = Time.now
		attendance.save
	end
end
