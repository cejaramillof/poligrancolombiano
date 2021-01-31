class FoodGroup < ApplicationRecord
  has_many :food_types, dependent: :destroy
  has_many :foods, :through => :food_type
end
