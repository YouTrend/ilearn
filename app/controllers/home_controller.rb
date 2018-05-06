class HomeController < ApplicationController
	before_action :authenticate_user!

	def index
	  @events = Event.all
	  @courses = Course.all
	  @students = Student.all
	end	
end
