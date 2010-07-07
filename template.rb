
# remove unused files
run "rm README"
run "rm public/index.html"
run "rm -f public/javascripts/*"
run "rm -f publuc/images/*"

# create root path

generate :controller, "Welcome index"
route "map.root :controller => 'welcome'"


# install unit test framework

gem "capybara",             ">= 0.3.8",          :group => [:test, :cucumber]
gem "cucumber-rails",       ">= 0.3.2",          :group => [:test, :cucumber]
gem "database_cleaner",     ">= 0.5.2",          :group => [:test, :cucumber]
gem "factory_girl_rails",   ">= 1.0.0",          :group => [:test, :cucumber]
gem "launchy",              ">= 0.3.5",          :group => [:test, :cucumber]
gem "rspec-rails",          ">= 2.0.0.beta.12",  :group => [:test, :cucumber]
gem "spork",                ">= 0.8.4",          :group => [:test, :cucumber]


generators = <<-GENERATORS

    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
GENERATORS

application generators

# handlino gems

gem 'handicraft_helper',  ">=1.0"

# gems

gem 'will_paginate', ">=3.0.pre"
gem 'delayed_job'
gem 'paperclip'

# JQuery

get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js",  "public/javascripts/jquery.js"
get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"


if yes?("Using Handicraft-theme ?")
  if File.directory?("../handicraft-theme")
    run "rm app/views/layouts/application.html.erb"
    run "cp ../handicraft-theme/app/views/layouts/fluid.html.erb app/views/layouts/application.html.erb"

    run "mkdir app/views/common"
    run "cp ../handicraft-theme/app/views/common/_main_navigation.html.erb app/views/common/_main_navigation.html.erb"
    run "cp ../handicraft-theme/app/views/common/_user_navigation.html.erb app/views/common/_user_navigation.html.erb"
   
    run "cp ../handicraft-theme/public/stylesheets/stickie.css public/stylesheets/"
    run "mkdir public/stylesheets/handicraft/"
    run "cp -R ../handicraft-theme/public/stylesheets/handicraft/* public/stylesheets/handicraft/"

    run "cp -R ../handicraft-theme/public/javascripts/core.js public/javascripts/"
  else
  end
end

jquery = <<-JQUERY
module ActionView::Helpers::AssetTagHelper
  remove_const :JAVASCRIPT_DEFAULT_SOURCES
  JAVASCRIPT_DEFAULT_SOURCES = %w(jquery.js rails.js core.js application.js)

  reset_javascript_include_default
end
JQUERY

initializer "jquery.rb", jquery

# for git
gitignore = <<-GITIGNORE
Thumbs.db
.DS_Store
tmp/
sphinx_*.*
*.log
*.pid
config/database.yml
*~
db/schema.rb
db/development_structure.sql
public/javascripts/all.js
public/stylesheets/all.css
coverage/
rcov/
public/system/*
config/*.sphinx.conf
db/sphinx/*
db/*.sqlite3
test/*
*.swp
GITIGNORE

remove_file ".gitignore"
create_file ".gitignore", gitignore

git :init
git :add => "."

docs = <<-DOCS

Run the following commands to complete the setup of #{app_name.humanize}:

% cd #{app_name}
% bundle install
% bundle lock
% script/rails generate rspec:install

Create Dashboard controller

% rails generate controller Dashboard index 

DOCS

log docs




