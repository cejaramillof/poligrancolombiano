class EstimatesController < ApplicationController
  before_action :set_estimate, only: [:show, :destroy]
  before_action :authenticate_user!
  before_action :outdated_user
  
  # GET /estimates
  # GET /estimates.json
  def index
    @estimates = current_user.estimates.paginate(:page => params[:page], :per_page => 4)
  end

  # GET /estimates/1
  # GET /estimates/1.json
  def show
    @estimate_food = EstimateFood.new
    @food_types = FoodType.all
    @estimate_foods = @estimate.estimate_foods
  end

  # GET /estimates/new
  def new
    @estimate = Estimate.new
  end

  # POST /estimates
  # POST /estimates.json
  def create
    @estimate = current_user.estimates.new(estimate_params)

    respond_to do |format|
      if @estimate.save
        format.html { redirect_to @estimate, notice: 'Nuevo cálculo creado con exito.' }
        format.json { render :show, status: :created, location: @estimate }
      else
        format.html { render :new }
        format.json { render json: @estimate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estimates/1
  # DELETE /estimates/1.json
  def destroy
    @estimate.destroy
    respond_to do |format|
      format.html { redirect_to estimates_url, notice: 'Cálculo destruido con exito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estimate
      @estimate = current_user.estimates.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estimate_params
      params.require(:estimate).permit(:user_id, :weight, :body_fat, :activity, :variation, :tdee, :suggested, :carbs, :proteins, :fats, :lean_weight, :fat_weight)
    end
end
