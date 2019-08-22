json.extract! news, :id, :tag, :title, :link, :icon, :created_at, :updated_at
json.url news_url(news, format: :json)
