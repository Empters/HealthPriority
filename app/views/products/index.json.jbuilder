json.array!($products) do |product|
  json.extract! product, :id, :name, :quantity, :viewed, :image, :price, :points, :description
  json.url product_url(product, format: :json)
end
