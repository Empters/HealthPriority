json.array!(Category.top_level) do |category|
  json.extract! category, :id
  json.url category_url(category, format: :json)
end
