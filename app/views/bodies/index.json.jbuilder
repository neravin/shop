json.array!(@bodies) do |body|
  json.extract! body, :id, :pol, :objective, :age, :fat, :bol, :kind_sport
  json.url body_url(body, format: :json)
end
