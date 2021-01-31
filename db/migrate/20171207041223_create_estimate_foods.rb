class CreateEstimateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :estimate_foods do |t|
      t.references :food_type, foreign_key: true
      t.references :estimate, foreign_key: true
      t.references :meal, foreign_key: true
      t.float :quantity, :default => 1

      t.timestamps
    end
  end
end
