class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    respond_to do |format|
      format.xlsx {
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename='items.xlsx'"
      }
      format.html { render :index }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_student
    @items = Item.all
    @items.each do |i|
      @student = Student.find_by(afts_id: i.afts_id) || Student.find_by(afts_id: Student.get_next_afts_id)
      @s = @student || StudentsController.new_by_item
      @s.afts_id = i.afts_id || Student.get_next_afts_id
      @s.name = i.name
      @s.card_id = i.card_id
      @s.school = i.school
      @s.grade = i.grade
      @s.user_id = 1
      @s.birthday = i.birthday
      @s.identity_code = i.identity_code
      @s.address =  i.address
      @s.remark =  i.remark
      if (!i.contact_name.nil? and i.contact_name != "")
        @c = @s.contacts[1]
        @c.name = i.contact_name
        @c.phone = i.contact_phone
        @c.phone2 = i.contact_phone2
        @c.phone3 = i.contact_phone3
        @c.save
      end
      @s.save
      @s.reload
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :quantity)
    end
end
