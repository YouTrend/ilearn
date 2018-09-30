class StudentsController < ApplicationController
	before_action :authenticate_user!	

	def index
      @students = Student.studying.page(params[:page]).per(20)
      @destroy_courses_flag = true
	end

	def search_auto_complete
      render json: Student.term_for(params[:term])
	end

	def search

	  name = params[:name];
	  render json: Student.where("name like ?", "%#{name}%")

	end	

	def others
      @students = Student.others.page(params[:page]).per(20)
      @destroy_courses_flag = false
	end

	def show
	  @student = Student.find(params[:id])
	end	

	def new
		@student = Student.new
		@student.afts_id = Student.get_next_afts_id
		@courses = Course.all
		2.times { @student.contacts.build }
	end

	def create
		puts current_user.id
		tmp_student_params = student_params
		if (Student.get_next_afts_id != tmp_student_params[:afts_id])
			flash[:error] = '學號格式有誤'
			redirect_to action: "new"	
			return
		end
		@student = Student.new(tmp_student_params)
	  # @user = User.new(:email => 'test@example.com', :password => 'password', :password_confirmation => 'password', :name => params[:user][:name])

		@student.user_id = current_user.id
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
		@contacts = Student.first.contacts.all
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

	def destroy_courses
	  @student = Student.find(params[:id])
	  @student.courses.destroy_all

	  redirect_to students_path
	end			

	def destroy
	  @student = Student.find(params[:id])

	  ActiveRecord::Base.transaction do
	    @student.courses.destroy_all
	    @student.destroy
	  end


		redirect_to others_students_url	"pOijrkl"
		
	end

	private

	def student_params
		params.require(:student).permit(:afts_id, :card_id, :school, :grade, :name, :birthday, :zkteco_id, :identity_code, :address, :remark, :course_ids => [], :contacts_attributes => [:id, :name, :phone, :notify_demand, :line_token])
	end	
end