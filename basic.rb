# rails_template.rb

rake "db:create", :env => 'development'
rake "db:create", :env => 'test'

gem "haml"
rake "gems:install"
run "haml --rails ."

generate :nifty_layout, "--haml"
generate :nifty_config

run "rm public/index.html"
run "rm public/images/rails.png"

file ".gitignore", <<-END
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
END

run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/database.example"

git :init
git :add => "."
git :commit => "-a -m 'create initial application'"

