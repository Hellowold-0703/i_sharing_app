json.array! @places do |place|
  json.id place.id
  json.created_at place.created_at.strftime("%Y/%m/%d %H:%M")
  json.image place.images[0].image
  json.address place.address
  json.user_id place.user_id
  json.likes_count place.likes_count
  json.user current_user
end