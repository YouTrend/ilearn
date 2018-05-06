class Courses::EventsController < ApplicationController
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

	def new
		@event = Event.new
	end



	private
	def event_params
		params.require(:event).permit(:name, :start_time, :end_time)
	end	

end
