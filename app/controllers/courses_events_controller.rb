class CoursesEventsController < ApplicationController
	include RailsTemporaryData::ControllerHelpers

	def create
	  @event = Event.new(event_params)
	  @course = Course.find(params[:course_id])
	  @event.name = @course.name
	  @event.course = @course

	  if(@event.save)

      else
		  flash[:error] = @event.errors.full_messages  
	  end	

	  redirect_to course_path(params[:course_id])

	end	

	def temp
	  @event = Event.new(event_params)

	  # @events = []

	  # @events.push(@event)
	  if !session[:events]
	  	session[:events] = []
	  end

	  session[:events] << @event
	  session[:name] = params[:event][:name]


	  # uuid = UUIDTools::UUID.timestamp_create().to_s

	  # set_tmp_data(uuid, { start_time: @event.start_time, end_time: @event.end_time})

	  # @course = Course.find(params[:course_id])
	  # @event.name = @course.name
	  # @event.course = @course

	  # if(@event.save)

   #    else
		 #  flash[:error] = @event.errors.full_messages  
	  # end	
	  redirect_to new_course_path
	end		
	

	def new
		@event = Event.new
	end

	def edit
		@course = Course.find(params[:course_id])
	    @event = Event.find(params[:id])
		respond_to do |format|
		  format.html {render template: "courses/events/edit.json.jbuilder"}
		  end
	end

	def index
	  @course = Course.find(params[:course_id])
	  @events = Event.where(course_id: @course.id)
	  respond_to do |format|
		format.html {render template: "courses/events/index.json.jbuilder"}
  	  end
	end

	def update
		@event = Event.find(params[:id])
		@event.update(event_params)
		redirect_to course_path(@event.course_id)
	end

	def destroy
		@event = Event.find(params[:event_id])
		@event.destroy
		redirect_to course_path(@event.course_id)
	end

	private
	def event_params
		params.require(:event).permit( :name, :start_time, :end_time, :color)
	end	

end
