json.product do
  json.id @jidori.product_id
  json.name @jidori.product.name
  json.base_points @jidori.product.base_points
  json.sponsor do
    json.id @jidori.product.sponsor.id
    json.name @jidori.product.sponsor.name
  end
end

json.jidori do
  json.id @jidori.id
  json.impressions @jidori.impressions
  json.points @jidori.points
  json.facebook_object_id @jidori.facebook_object_id
  json.image_file_name @jidori.image_file_name
end

json.information do
  json.user_total_points @jidori.user.total_points
  json.message '成功'
  json.code 201
end
