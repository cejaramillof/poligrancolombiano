class CreateEstimates < ActiveRecord::Migration[5.1]
  def change
    create_table :estimates do |t|
      t.references :user, foreign_key: true
      t.float :weight
      t.float :body_fat, :default => 0
      t.float :activity
      t.integer :variation, :default => 0
      t.integer :tdee
      t.integer :suggested

      t.timestamps
    end
  end
end
