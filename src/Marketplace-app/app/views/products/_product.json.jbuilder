json.extract! product, :id, :title, :description, :brand_id, :style_id, :size_id, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
