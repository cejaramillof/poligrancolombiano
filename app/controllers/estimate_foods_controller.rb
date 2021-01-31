class EstimateFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_estimate_food, only: [:update, :destroy]
  def create
    @estimate = current_user.estimates.first
    @estimate_food = EstimateFood.new(estimate_food_params)
    @estimate_food.save
    @estimate.save
  end

  def update
    @estimate_food.update(estimate_food_params)
    @estimate = @estimate_food.estimate
    @estimate_foods = @estimate.estimate_foods
  end

  def destroy
    @estimate = @estimate_food.estimate
    @estimate_food.destroy
    @estimate_foods = @estimate.estimate_foods
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_estimate_food
    @estimate_food = EstimateFood.find(params[:id])
  end
  def set_estimate
    @estimate = Estimate.find(params[:estimate_id])
  end
  def estimate_food_params
    params.require(:estimate_food).permit(:quantity, :food_type_id, :meal_id, :estimate_id)
  end
end
