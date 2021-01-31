class EstimateFood < ApplicationRecord
  belongs_to :food_type
  belongs_to :estimate
  belongs_to :meal
  attr_accessor :total_proteins, :total_carbs, :total_fats, :total_kcal

  def total_proteins
    food_type.proteins * quantity
  end
  def total_carbs
    food_type.carbs * quantity
  end
  def total_fats
    food_type.fats * quantity
  end
  def total_kcal
    food_type.kcal * quantity
  end
end
