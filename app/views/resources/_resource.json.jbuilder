json.extract! resource, :id, :name, :price, :created_at, :updated_at
json.url resource_url(resource, format: :json)