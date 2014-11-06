json.array!($root_categories) do |category|
  json.extract! category, :id
  json.url category_url(category, format: :json)
end
