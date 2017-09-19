class ContestantsController < ApplicationController
  before_action :set_contestant, only: [:edit, :update, :destroy, :upvote]
  before_action :set_pageant
  #before_action :already
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
    current_user.find_votes.each do |vote|
      if(vote.votable_id == @contestant.id and vote.voter_id == current_user.id and (Time.now - vote.created_at) <= 24.hours )
        rem = 24.hours- (Time.now - vote.created_at)
        rem  = (rem/1.hour).round
        rem = rem.to_s
        flash[:notice] = 'You have already voted for today! ' +rem+ ' hours remaining to vote again'
        redirect_to root_path
        return
      # else
    
      end
      
    end
    @contestant.upvote_from current_user
    flash[:success] = "Thank you for voting"
    redirect_to pageant_path(@contestant.pageant.id)

    
  #   if current_user.voted_on?(@contestant) && @contestant.updated_at > Time.now - 24.hours.ago
  #   #  if @contestant.updated_at < Time.now - 24.hours
  #   flash[:notice] = "You have already voted for today!"
  #     redirect_to root_path
    
  #   else
  #   @contestant.upvote_from current_user
  # # @upvote.save
  #   flash[:success] = "Thank you for voting"
  #   redirect_to pageant_path(@contestant.pageant.id)
  
  #   # end
  #   end
  
  
  end


  private
    # Use callbacks to share common setup or constraints between actions.
  
   # def already
   #  if @contestant.updated_at < Time.now - 24.hours
      # if @contestant.upvote_by.updated_at < Time.now - 24.hours
   #   flash[:notice] = "You only have 1 vote try tomorow"
  #     redirect_to root_path
  #   end
  #  end
    
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