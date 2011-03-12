# full.rb
# Used for Rails 3.0.x apps
# Remember to create a gemset with the project's name
# and install Rails in it first.

# create rvmrc file
create_file ".rvmrc", "rvm gemset use #{app_name}"

gem "haml-rails"
gem "sass"
# hpricot and ruby_parser required by haml
gem "hpricot", :group => :development
gem "ruby_parser", :group => :development
gem "nifty-generators"
gem "simple_form"
gem "jquery-rails"

# authentication and authorization
gem "devise"
gem "cancan"

# rspec, factory girl, webrat, autotest for testing
gem "rails3-generators", :group => [ :development ]
gem "rspec-rails", :group => [ :development, :test ]
gem "factory_girl_rails", :group => [ :development, :test ]
gem "webrat", :group => :test
gem "ffaker", :group => :test
gem "autotest", :group => :test

run 'bundle install'

rake "db:create", :env => 'development'
rake "db:create", :env => 'test'

generate 'nifty:layout --haml'
remove_file 'app/views/layouts/application.html.erb' # use nifty layout instead
generate 'simple_form:install'
generate 'nifty:config'
remove_file 'public/javascripts/rails.js' # jquery-rails replaces this
generate 'jquery:install --ui'
generate 'rspec:install'
inject_into_file 'spec/spec_helper.rb', "\nrequire 'factory_girl'", :after => "require 'rspec/rails'"
inject_into_file 'config/application.rb', :after => "config.filter_parameters += [:password]" do
  <<-eos
    
    # Customize generators
    config.generators do |g|
      g.stylesheets false
      g.form_builder :simple_form
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
  eos
end
run "echo '--format documentation' >> .rspec"

# authentication and authorization setup
generate "devise:install"
generate "devise User"
generate "devise:views"
rake "db:migrate"
generate "cancan:ability"

# clean up rails defaults
remove_file 'public/index.html'
remove_file 'rm public/images/rails.png'
run 'cp config/database.yml config/database.example'
run "echo 'config/database.yml' >> .gitignore"

# commit to git
git :init
git :add => "."
git :commit => "-a -m 'create initial application'"

say <<-eos
  ============================================================================
  Your new Rails application is ready to go.
  
  Don't forget to scroll up for important messages from installed generators.
eos
