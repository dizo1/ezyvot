class PageantsController < ApplicationController
  before_action :set_pageant, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /pageants
  # GET /pageants.json
  def index
    @pageants = Pageant.search(params[:search])
  end

  # GET /pageants/1
  # GET /pageants/1.json
  def show
    @pageant = Pageant.find(params[:id])
    @contestants = Contestant.where(pageant_id: @pageant.id).order("created_at DESC")
  end

  # GET /pageants/new
  def new
    @pageant = current_user.pageants.build
  end

  # POST /pageants
  # POST /pageants.json
  def create
    @pageant = current_user.pageants.build(pageant_params)

    respond_to do |format|
      if @pageant.save
        format.html { redirect_to @pageant, notice: 'Pageant was successfully created.' }
        format.json { render :show, status: :created, location: @pageant }
      else
        format.html { render :new }
        format.json { render json: @pageant.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET /pageants/1/edit
  def edit
  end

  # PATCH/PUT /pageants/1
  # PATCH/PUT /pageants/1.json
  def update
    respond_to do |format|
      if @pageant.update(pageant_params)
        format.html { redirect_to @pageant, notice: 'Pageant was successfully updated.' }
        format.json { render :show, status: :ok, location: @pageant }
      else
        format.html { render :edit }
        format.json { render json: @pageant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pageants/1
  # DELETE /pageants/1.json
  def destroy
    @pageant.destroy
    respond_to do |format|
      format.html { redirect_to pageants_url, notice: 'Pageant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pageant
      @pageant = Pageant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pageant_params
      params.require(:pageant).permit(:name, :description, :category, :startdate, :enddate, :time_zone, :image)
    end
end
