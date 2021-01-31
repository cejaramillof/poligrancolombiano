json.extract! food, :id, :name, :quantity, :home_quantity, :food_type_id, :created_at, :updated_at
json.url food_url(food, format: :json)
