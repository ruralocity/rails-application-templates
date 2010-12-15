# rails_template.rb

gem "haml", ">= 3.0.14"
gem "nifty-generators", ">= 0.4.0"
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

