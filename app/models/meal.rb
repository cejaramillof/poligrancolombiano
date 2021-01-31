class Meal < ApplicationRecord
  belongs_to :user, optional: true
  has_many :estimate_foods, dependent: :destroy
end
