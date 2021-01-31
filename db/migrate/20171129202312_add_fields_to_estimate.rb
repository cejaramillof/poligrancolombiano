class AddFieldsToEstimate < ActiveRecord::Migration[5.1]
  def change
    add_column :estimates, :fats, :float
    add_column :estimates, :carbs, :float
    add_column :estimates, :proteins, :float
  end
end
