class ContestantsController < ApplicationController
  before_action :set_contestant, only: [:edit, :update, :destroy, :upvote]
  before_action :set_pageant
  before_action :authenticate_user!
  # GET /contestants
  # GET /contestants.json
  #def index
  #  @contestants = Contestant.all
  #end

  # GET /contestants/1
  # GET /contestants/1.json
  def show
    @contestant = Contestant.find(params[:id])
    @contestant.pageant_id = pageant.id
  end

  # GET /contestants/new
  def new
    #@pageant = Pageant.find(params[:id])
    @contestant = Contestant.new
  end

  # POST /contestants
  # POST /contestants.json
  def create
    @contestant = Contestant.new(contestant_params)
    @contestant.user_id = current_user.id
    @contestant.pageant_id = @pageant.id
    respond_to do |format|
      if @contestant.save
        format.html { redirect_to @pageant, notice: 'Contestant was successfully created.' }
        format.json { render :show, status: :created, location: @contestant }
      else
        format.html { render :new }
        format.json { render json: @contestant.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /contestants/1/edit
  def edit
  end

  # PATCH/PUT /contestants/1
  # PATCH/PUT /contestants/1.json
  def update
    respond_to do |format|
      if @contestant.update(contestant_params)
        format.html { redirect_to @contestant, notice: 'Contestant was successfully updated.' }
        format.json { render :show, status: :ok, location: @contestant }
      else
        format.html { render :edit }
        format.json { render json: @contestant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contestants/1
  # DELETE /contestants/1.json
  def destroy
    @contestant.destroy
    respond_to do |format|
      format.html { redirect_to contestants_url, notice: 'Contestant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def upvote
    @contestant = Contestant.find(params[:id])
    #current_user = User.find_by_id(session[:user_id])
    @contestant.upvote_from current_user
    #current_user.upvotes @contestant
    #redirect_to pageants_path(@pageant.id)
    flash[:success] = "You have voted successfully"
    #redirect_to pageants_path(@pageant)
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contestant
      @contestant = Contestant.find(params[:id])
    end
    def set_pageant
      @pageant = Pageant.find_by_id(params[:pageant_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def contestant_params
      params.require(:contestant).permit(:con_num, :name, :profile, :image)
    end
end