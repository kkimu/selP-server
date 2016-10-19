json.user do
  json.id @user.id
  json.name @user.name
  json.email @user.email
  json.total_points @user.total_points
  json.created_at @user.created_at
end
