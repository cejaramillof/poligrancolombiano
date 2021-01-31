class CreateFoodTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :food_types do |t|
      t.string :name
      t.float :kcal
      t.float :proteins
      t.float :carbs
      t.float :fats
      t.references :food_group, foreign_key: true

      t.timestamps
    end
  end
end
