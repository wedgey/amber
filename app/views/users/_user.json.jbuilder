json.extract! user, :id, :username, :password_digest, :firstname, :lastname, :email, :country, :city, :phone, :address, :created_at, :updated_at
json.url user_url(user, format: :json)