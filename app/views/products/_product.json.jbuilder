json.extract! product, :id, :name, :price, :image, :category_id, :stock, :description, :cod_eligible, :release_date, :created_at, :updated_at
json.url product_url(product, format: :json)
