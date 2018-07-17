class CoursesController < ApplicationController
	include RailsTemporaryData::ControllerHelpers
	before_action :authenticate_user!

	def new
	  # @events = []
	  # @event = Event.new
	  @course = Course.new
	  @students = []
	  @title = "新增班級"
	  # @event_expanded = false
	  
	  # if session[:events]
	  # 	  @course.name = session[:name]

	  # 	  session[:events].each do|e|
	  # 	  	event = Event.new
	  # 	    event.start_time = e["start_time"]
	  # 	    event.end_time = e["end_time"]	  

	  # 	    @events << event
	  # 	  end	

	  # 	  @course.events = @events
	  #     @event_expanded = true
	  # end	


	end	

	def show
	  @course = Course.find(params[:id])
	  @events = Event.where(course_id: @course.id)
	  @event = Event.new
	  @students = @course.students.page(params[:page]).per(20)	  
	end		

	def edit
	  @course = Course.find(params[:id])
	  @students = @course.students
	  @title = "編輯班級"
	end	

	def update
	  @course = Course.find(params[:id])

	  students = []

		if (!params["students"].nil?)
			params["students"].each do |s|
			student = Student.find(s[:student][:id])

			students <<  student
			end
			@course.students = students
		end
		
	  @course.save!

	  redirect_to course_path(@course)
	  # if(@course.save)
		 #  flash[:notice] = '編輯班級成功'
		 #  redirect_to course_path(@course)

   #    else
		 #  flash[:error] = @course.errors.full_messages
		 #  render :new
	  # end	
	end	
	

	def create
	  @course = Course.new(course_params)

	  students = []
		if (!params["students"].nil?)
			params["students"].each do |s|
			student = Student.find(s[:student][:id])

			students <<  student
			end
			@course.students = students
		end

	  @course.save!  

	  redirect_to course_path(@course)


	end	

	def event_new
	  @event = Event.new
	  render "courses/show"
	end	

	private

	def course_params
		params.require(:course).permit(:name, :description)
	end		

	def event_params(event_params)
		event_params.require(:event).permit(:name, :start_time, :end_time)
	end	

end
