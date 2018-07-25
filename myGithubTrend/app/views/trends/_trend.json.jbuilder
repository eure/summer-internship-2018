json.extract! trend, :id, :name, :lang, :description, :star_count, :url, :created_at, :updated_at
json.url trend_url(trend, format: :json)
