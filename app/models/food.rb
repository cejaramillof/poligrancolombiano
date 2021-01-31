class Food < ApplicationRecord
  belongs_to :food_type
  delegate :food_group, :to => :food_type, :allow_nil => true
end
