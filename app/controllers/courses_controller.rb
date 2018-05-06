class CoursesController < ApplicationController
	before_action :authenticate_user!

	def new
	  @events = Event.all
	  @event = Event.new
	  @course = Course.new
	end

	def show
	  @course = Course.find(params[:id])
	  @events = Event.all
	  @event = Event.new
	  @students = @course.students.page(params[:page]).per(20)	  
	end		

	def edit
	  @course = Course.find(params[:id])
	  @events = Event.all
	  @event = Event.new
	  @students = @course.students.page(params[:page]).per(20)	  
	end	

	def update
	  @course = Course.find(params[:id])

	  events = []

	  params["events"].each do |e|
		event = Event.new(event_params(e))
		event.name = @course.name
		event.course = @course

		events <<  event
	  end

	  ActiveRecord::Base.transaction do
	  	# Course.find_by(id: @course.id)

	  	@course.save!
	  	events.each do |event|
	  		event.save!
	  	end	
	  end	  

	  flash[:notice] = '編輯班級成功'
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

	  params["events"].each do |event|
	    if event["start_time"] != "" || event["end_time"] != ""
	      Event.create(event_params(event))
	    end
	  end

	  if(@course.save)
		  flash[:notice] = '新增班級成功'
		  redirect_to course_path(@course)

      else
		  flash[:error] = @course.errors.full_messages
		  render :new
	  end	

	end	

	def event_new
	  @event = Event.new
	  render "courses/show"
	end	

	private

	def course_params
		params.require(:course).permit(:name)
	end		

	def event_params(event_params)
		event_params.require(:event).permit(:name, :start_time, :end_time)
	end	

end
