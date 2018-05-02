class CoursesController < ApplicationController
	before_action :authenticate_user!

	def new
	  @events = Event.all
	  @event = Event.new
	  @course = Course.new
	end

	def create
	  @course = Course.new(course_params)


	  if(@course.save)
		  flash[:notice] = '新增班級成功'
		  redirect_to action: "new"	

      else
		  flash[:error] = @course.errors.full_messages
		  render :new
	  end	

	end	

	private

	def course_params
		params.require(:course).permit(:name)
	end		
end
