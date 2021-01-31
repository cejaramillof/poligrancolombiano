json.extract! food_type, :id, :name, :kcal, :proteins, :carbs, :fats, :food_group_id, :created_at, :updated_at
json.url food_type_url(food_type, format: :json)
