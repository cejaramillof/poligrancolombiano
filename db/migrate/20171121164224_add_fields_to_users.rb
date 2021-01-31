class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :sex, :boolean
    add_column :users, :height, :float
    add_column :users, :birth_date, :date
  end
end
