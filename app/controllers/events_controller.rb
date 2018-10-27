class EventsController < ApplicationController

	def show

	end

	def index
	  @events = Event.where(start_time: params[:start]..params[:end])
	end
	
	private
	def event_params
		params.require(:event).permit(:name, :start_time, :end_time, :color)
	end		

end
