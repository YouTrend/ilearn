class AttendancesController < ApplicationController
	require 'oauth2'
	require 'net/http'
	require 'openssl'
	require 'uri'
	require 'json'
	AUTH_SITE = 'https://notify-bot.line.me'
	API_SITE  = 'https://notify-api.line.me'

	CLIENT_ID     = $liensettings["client_id"]
	CLIENT_SECRET = $liensettings["client_secret"]
	CALLBACK      = File.join($liensettings["callback"], "oauth/callback")
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
		@attendance_by_student = Attendance.getAttendance(student)
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
		#run_line_notify
		contacts = student.contacts
		if (!contacts.nil?)
			contacts.each do |c|
				if (c.notify_demand and (!c.line_token.nil? and !c.line_token.empty?))
					send_message(c.line_token, c.name + "您好：您的愛子" + student.name + "已經上課囉！於" + @attendance.start_time.to_s)
				end
			end
		end
	end

	def setFinishClass (student,attendance)
		attendance.end_time = Time.now
		attendance.save
	end

	def send_message (token, message)
		p message
		res = msg(token, message)

		case res
		when Net::HTTPSuccess
			@result = "successful"
		else
			j = JSON.parse(res.body)
			@result = "[status:#{j["status"]}] #{j["message"]}"
		end
	end

	def msg(token, message)
		url = URI.parse(File.join(API_SITE, 'api/notify'))
		req = Net::HTTP::Post.new(url.path)
		req.content_type = "application/x-www-form-urlencoded"
		req['Authorization'] = "Bearer #{token}"
		req.set_form_data({
			"message" => message
		})

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE


		http.start { |h|
			h.request(req)
		}
	end
end
