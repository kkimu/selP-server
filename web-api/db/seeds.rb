# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
    [
        {name: 'koutake', email: 'a@sample.com', auth_token: 'EAACEdEose0cBAMwB8nB0Xr3QPjehI6v7ru2IDjpf7yeJZBaxmYAuQ7zIbkXZCKNH2ObUlNja0yROsmkR3BdSJtRF5ZB4156U8eDNMBuPWn2j4OPLkHUZA0hH4VEsspHZCQ2WVdfwYZAW8CSfSBH5FgDMjyqcVwkwQNgpINcCp9e0Xrxrx11RJm'
        },
        {name: 'shiitake', email: 'b@sample.com', auth_token: 'EAACEdEose0cBAMwB8nB0Xr3QPjehI6v7ru2IDjpf7yeJZBaxmYAuQ7zIbkXZCKNH2ObUlNja0yROsmkR3BdSJtRF5ZB4156U8eDNMBuPWn2j4OPLkHUZA0hH4VEsspHZCQ2WVdfwYZAW8CSfSBH5FgDMjyqcVwkwQNgpINcCp9e0Xrxrx11RJm'}
    ]
)
Campaign.create(
    [
        {name: 'おーいお茶！', base_points: 100, description: 'お茶を飲んでポイントをもらおう！', sponsor_id: 1, file_path: '/static/campaign/ocha.jpg', file_name: 'ocha.jpg'},
        {name: '本', base_points: 110, description: '本を読め。', sponsor_id: 1, file_path: '/static/campaign/book.jpg', file_name: 'book.jpg'},
        {name: 'カロリーメイト', base_points: 30, description: 'カロリーメイト チーズ味', sponsor_id: 2, file_path: '/static/campaign/calorie_mate.jpg', file_name: 'calorie_mate.jpg'}
    ]
)
