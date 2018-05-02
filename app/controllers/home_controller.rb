class HomeController < ApplicationController
	before_action :authenticate_user!

	def index
	  @events = Event.all
	  @courses = Course.all
	end	
end
