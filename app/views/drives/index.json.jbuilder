json.array!(@drives) do |drife|
  json.extract! drife, :id, :city, :num_passengers, :driver_id
  json.url drife_url(drife, format: :json)
end
