# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
    {name: "koutake", email: "a@sample.com", auth_token: "aaaaaaaaaaaaaaaa"}
)

User.create(
    {name: "shiitake", email: "b@sample.com", auth_token: "bbbbbbbbbbbbbbbbb"}
)

# 自撮り
Jidori.create(
    {campaign_id: 1, user_id: 1, post_url: "sample.com", impression: 3, points: 3, image: "/aaaaaaaaa"}
)

Jidori.create(
    {campaign_id: 2, user_id: 1, post_url: "sample.com", impression: 3, points: 3, image: "/aaaaaaaaa"}
)

Jidori.create(
    {campaign_id: 1, user_id: 2, post_url: "sample.com", impression: 3, points: 3, image: "/aaaaaaaaa"}
)
Jidori.create(
    {campaign_id: 2, user_id: 1, post_url: "sample.com", impression: 3, points: 3, image: "/aaaaaaaaa"}
)


# キャンペーンデータをやる
Campaign.create(
    {name: "おーいお茶！", base_points: 2, description: "お茶を飲んでポイントをもらおう！", sponsor_id: 1, image: "/aaaa"}
)

Campaign.create(
    {name: "本", base_points: 2, description: "本を読め。", sponsor_id: 1, image: "/bbbb"}
)