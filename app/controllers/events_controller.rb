class EventsController < ApplicationController
	def create
	  @event = Event.new(event_params)

	  if(@event.save!)
		  edirect_to course_path(params[:course_id])
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
