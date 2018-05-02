class DepartmentsController < ApplicationController
	before_action :authenticate_user!	

	def index
	  @departments = Department.all
	end

	def show
	  @department = Department.find(params[:id])
	end	

	def edit
	  @department = Department.find(params[:id])
	end		

	def update
	  @department = Department.find(params[:id])
	  if(@department.update(department_params))
	  	redirect_to root_path
	  else
	  	flash[:error] = @department.errors.full_messages
	  	redirect_to @department
	  end	

	end

	private

	def department_params
		params.require(:department).permit(:name, :phone, :address, :certificate_number)
	end	
end
