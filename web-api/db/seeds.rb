# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
    [
        {name: 'tsrd', email: 'a@sample.com', auth_token: 'EAACEdEose0cBAAiolk61gXTzZBG5WbVTLh42UC69f2x7KpvE5buH15e3cYW0ZAUfH7LZBCi0MZBs74Tv1V3bZBdezh7edvTbN83HcGQmBMY7DHY2wIYngNI1OclVhVle7ZCYo9CovawMEnIRSXOnZBAgiSatSOKFV6a3SYKZBHfkHwZDZD'},
        {name: 'shiitake', email: 'b@sample.com', auth_token: 'EAACEdEose0cBAAiolk61gXTzZBG5WbVTLh42UC69f2x7KpvE5buH15e3cYW0ZAUfH7LZBCi0MZBs74Tv1V3bZBdezh7edvTbN83HcGQmBMY7DHY2wIYngNI1OclVhVle7ZCYo9CovawMEnIRSXOnZBAgiSatSOKFV6a3SYKZBHfkHwZDZD'}
    ])

Sponsor.create(
    [
        {name: '伊藤園', email: 'itouen@sample.com'},
        {name: '大塚製薬', email: 'ootsuka@sample.com'}
    ])

Product.create(
    [
        {name: 'カロリーメイト', base_points: 30, like_points: 2, description: 'カロリーメイト チーズ味', sponsor_id: 2, image: File.new("#{Rails.root}/public/img/calorie_mate.jpg")}
    ])

