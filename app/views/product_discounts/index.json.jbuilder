json.array!(@product_discounts) do |product_discount|
  json.extract! product_discount, :id
  json.url product_discount_url(product_discount, format: :json)
end
