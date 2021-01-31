class FoodType < ApplicationRecord
  belongs_to :food_group
  has_many :estimates
  has_many :estimate_foods, dependent: :destroy
  has_many :foods, dependent: :destroy
end
