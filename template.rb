
# remove unused files
run "rm README"
run "rm public/index.html"
run "rm -f public/javascripts/*"
run "rm -f publuc/images/*"

# install unit test framework

gem 'rspec', ">=2.0.0.beta.9", :group => :test
gem 'rspec-rails', ">=2.0.0.beta.9.1",  :group => :test
gem "factory_girl", :group => :test
gem 'capybara', :group => :test
gem 'database_cleaner', :group => :test
gem 'cucumber-rails', :group => :test
gem 'cucumber', :group => :test
gem 'spork', :group => :test
gem 'launchy' , :group => :test

generators = <<-GENERATORS

    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
GENERATORS

application generators

# plugins

plugin 'handicraft_helper', :git => 'git://github.com/ihower/handicraft_helper.git'
plugin 'handicraft_ujs', :git => 'git://github.com/ihower/handicraft_ujs.git'

# gems

gem 'will_paginate', ">=3.0.pre"
gem 'delayed_job'
gem 'paperclip'

# JQuery

get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js",  "public/javascripts/jquery.js"
get "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js", "public/javascripts/jquery-ui.js"
get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"

jquery = <<-JQUERY
module ActionView::Helpers::AssetTagHelper
  remove_const :JAVASCRIPT_DEFAULT_SOURCES
  JAVASCRIPT_DEFAULT_SOURCES = %w(jquery.js jquery-ui.js rails.js)

  reset_javascript_include_default
end
JQUERY

initializer "jquery.rb", jquery

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
  else
  end
end

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




