class Courses::EventsController < ApplicationController
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



	private
	def event_params
		params.require(:event).permit(:name, :start_time, :end_time)
	end	

end
