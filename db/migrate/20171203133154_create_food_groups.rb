class CreateFoodGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :food_groups do |t|
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end
