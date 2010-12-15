# restful_auth_acl.rb
# Used for Rails 2.3 apps
# Includes RESTful Authentication and RESTful ACL for authentication/authorization.

rake "db:create", :env => 'development'
rake "db:create", :env => 'test'

gem "haml"
gem "restful_authentication"
gem "restful_acl"
rake "gems:install"

run "haml --rails ."
generate :nifty_layout, "--haml"
generate :nifty_config

run "rm public/index.html"
run "rm public/images/rails.png"

generate :authenticated, "user session"

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

