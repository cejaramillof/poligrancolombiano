class Estimate < ApplicationRecord
  before_save :set_tdee, :set_suggested
  before_save :total_proteins, :total_carbs, :total_fats, :total_kcal
  attr_accessor :fat_weight, :lean_weight, :total_proteins, :total_carbs, :total_fats, :total_kcal
  belongs_to :user
  has_many :estimate_foods, dependent: :destroy
  has_many :meals, through: :estimate_foods
  has_many :food_types, through: :estimate_foods
  enum activity: [:sedentaria, :baja, :activa, :alta]
  validates :weight, :numericality => true
  validates :carbs, :numericality => true
  validates :proteins, :numericality => true
  validates :fats, :numericality => true
  validate :sum_equals_100

  default_scope { order(created_at: :desc) }

  def sum_equals_100
    if carbs + proteins + fats != 100
      errors.add(:base, 'la suma de los 3 macronutrientes debe dar 100%')
    end
  end
  def activity_n
    if user.male?
      if user.age >= 19
        case activity
          when "sedentaria"
            1
          when "baja"
            1.11
          when "activa"
            1.25
          else
            1.48
        end
      else
        case activity
          when "sedentaria"
            1
          when "baja"
            1.13
          when "activa"
            1.26
          else
            1.42
        end
      end
    else
      if user.age >= 19
        case activity
          when "sedentaria"
            1
          when "baja"
            1.12
          when "activa"
            1.27
          else
            1.45
        end
      else
        case activity
          when "sedentaria"
            1
          when "baja"
            1.16
          when "activa"
            1.31
          else
            1.56
        end
      end
    end
  end

  def set_tdee
    if user.male?
      if user.age >= 19
        self.tdee = 662 - (9.53 * user.age) + activity_n * ((15.91 * lean_weight)+(539.6 * user.height))
      elsif user.age >= 9
        self.tdee = 88.5 - (61.9 * user.age) + activity_n * ((26.7 * lean_weight)+((903 * user.height) + 25))
      else
        self.tdee = 88.5 - (61.9 * user.age) + activity_n * ((26.7 * lean_weight)+((903 * user.height) + 20))
      end
    else
      if user.age >= 19
        self.tdee = 354 - (6.91 * user.age) + activity_n * ((9.36 * lean_weight)+(726 * user.height))
      elsif user.age >= 9
        self.tdee = 135.3 - (30.8 * user.age) + activity_n * ((10.0 * lean_weight)+((934 * user.height) + 25))
      else
        self.tdee = 135.3 - (30.8 * user.age) + activity_n * ((10.0 * lean_weight)+((934 * user.height) + 20))
      end
    end
  end

  def set_suggested
    self.suggested = tdee + (tdee * variation / 100)
  end

  def fat_weight
    weight * (body_fat / 100)
  end

  def lean_weight
    weight - fat_weight
  end

  def gr_proteins
    (suggested * (proteins / 100)) / 4
  end
  def gr_carbs
    (suggested * (carbs / 100)) / 4
  end
  def gr_fats
    suggested * (fats / 100) / 9
  end

  def total_proteins
    estimate_foods.collect { |ef| ef.valid? ? (ef.quantity * ef.food_type.proteins) : 0 }.sum
  end
  def total_carbs
    estimate_foods.collect { |ef| ef.valid? ? (ef.quantity * ef.food_type.carbs) : 0 }.sum
  end
  def total_fats
    estimate_foods.collect { |ef| ef.valid? ? (ef.quantity * ef.food_type.fats) : 0 }.sum
  end
  def total_kcal
    estimate_foods.collect { |ef| ef.valid? ? (ef.quantity * ef.food_type.kcal) : 0 }.sum
  end
end
