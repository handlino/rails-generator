gem 'will_paginate',      ">=3.0.pre"
gem 'handicraft_helper',  ">=1.1"
gem 'delayed_job'
gem 'paperclip'

gem "factory_girl_rails", ">= 1.0.0",           :group => [:test, :cucumber]
gem "rspec-rails",        ">= 2.0.0.beta.9.1",  :group => [:test, :cucumber]

gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'

apply 'http://datamapper.org/templates/rails/gemfile.rb'
apply 'http://datamapper.org/templates/rails/config.rb'
apply 'http://datamapper.org/templates/rails/database.yml.rb'

inject_into_file  'app/controllers/application_controller.rb',
                  "require 'dm-rails/middleware/identity_map'\n",
                  :before => 'class ApplicationController'

inject_into_class 'app/controllers/application_controller.rb',
                  'ApplicationController',
                  "  use Rails::DataMapper::Middleware::IdentityMap\n"

application <<-GENERATORS
    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
GENERATORS

run "bundle install"
run "rails g authlogic:session user_session"

# create root path
generate :controller, "Welcome index"
route "map.root :controller => 'welcome'"

# remove unused files
run "rm README"
run "rm public/index.html"
run "rm -f public/javascripts/*"
run "rm -f publuc/images/*"

apply File.dirname(__FILE__) + '/common/jquery.rb'
apply File.dirname(__FILE__) + '/common/handicraft-theme.rb'
apply File.dirname(__FILE__) + '/common/git.rb'

log <<-DOCS

Run the following commands to complete the setup of #{app_name.humanize}:

% cd #{app_name}
% bundle install
% bundle lock
% script/rails generate rspec:install

DOCS
