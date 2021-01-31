class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.float :quantity
      t.string :home_quantity
      t.references :food_type, foreign_key: true

      t.timestamps
    end
  end
end
