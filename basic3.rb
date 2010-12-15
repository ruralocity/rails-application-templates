# basic.rb
# Used for Rails 3.0.x apps

gem "haml"
gem "nifty-generators"
gem "sqlite3-ruby"

run 'bundle install'

rake "db:create", :env => 'development'
rake "db:create", :env => 'test'

generate :nifty_layout, "--haml"
generate :nifty_config

run "rm public/index.html"
run "rm public/images/rails.png"

run "cp config/database.yml config/database.example"

git :init
git :add => "."
git :commit => "-a -m 'create initial application'"

