json.extract! contestant, :id, :con_num, :name, :profile, :image, :created_at, :updated_at
json.url contestant_url(contestant, format: :json)
