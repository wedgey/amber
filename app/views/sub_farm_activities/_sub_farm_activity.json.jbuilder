json.extract! sub_farm_activity, :id, :sub_farm_id, :activity_id, :amount, :date, :title, :note, :created_at, :updated_at
json.url sub_farm_activity_url(sub_farm_activity, format: :json)