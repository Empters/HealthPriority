json.array!(@manufacturers) do |manufacturer|
  json.extract! manufacturer, :id
  json.url manufacturer_url(manufacturer, format: :json)
end
