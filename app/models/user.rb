class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum sex: {male: true, female: false}
  validates_presence_of :birth_date, :height, :sex
  has_many :estimates, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :estimate_foods, through: :estimates
  accepts_nested_attributes_for :meals, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }
  def active_for_authentication?
        super && approved?
  end
  def age
    now = Time.now.utc.to_date
    now.year - birth_date.year - (birth_date.to_date.change(:year => now.year) > now ? 1 : 0)
  end

end
