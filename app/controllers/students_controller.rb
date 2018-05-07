class StudentsController < ApplicationController
	before_action :authenticate_user!	

	def index
      @students = Student.studying.page(params[:page]).per(20)
	end

	def others
      @students = Student.others.page(params[:page]).per(20)
	end

	def show
	  @student = Student.find(params[:id])
	end	

	def new
	  @student = Student.new
	  @courses = Course.all
	end

	def create
	  @student = Student.new(student_params)

	  # @user = User.new(:email => 'test@example.com', :password => 'password', :password_confirmation => 'password', :name => params[:user][:name])

	  # @student.user = @user
	  if(@student.save)
		  flash[:notice] = '新增學生成功'
		  redirect_to action: "new"	

      else
		  flash[:error] = @student.errors.full_messages
		  render :new
	  end	

	end	

	def edit
	  @student = Student.find(params[:id])
	end

	def update
	  @student = Student.find(params[:id])
	  

	  if(@student.update(student_params))
		redirect_to students_path
      else
		  flash[:error] = @student.errors.full_messages
		  render :new
	  end		  

	end	


	private

	def student_params
		params.require(:student).permit(:afts_id, :card_id, :school, :grade, :name, :course_ids => [])
	end	
end
