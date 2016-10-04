# README

* Ruby version: `2.3`
* Database initialization
```sh
bundle exec rake db:migrate
bundle exec rake db:seed
```

* Add environmental variables
```sh
export FB_TOKEN='xxx'
export SECRET_KEY_BASE='yyy' # Using `rake secret`
export {PROJECT}_DATABASE_PASSWORD={pg_password}
export STATIC_FILES_ROOT='foo/bar/static'
```

* Operation test in local
```sh
rails s
cd ../selP-cv
python app.py
cd static/jidoris
curl -F 'image_binary=@selfy.jpg' http://localhost:3000/users/1/jidoris
```
