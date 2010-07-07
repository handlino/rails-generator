# remove unused files. The default Gemfile is unwanted.
run "rm -f Gemfile README public/index.html public/javascripts/* publuc/images/*"
create_file 'Gemfile'

apply File.dirname(__FILE__) + '/common/gems.rb'

RAILS_VERSION = '~> 3.0.0.beta4'
gem 'activesupport',      RAILS_VERSION, :require => 'active_support'
gem 'actionpack',         RAILS_VERSION, :require => 'action_pack'
gem 'actionmailer',       RAILS_VERSION, :require => 'action_mailer'
gem 'railties',           RAILS_VERSION, :require => 'rails'

gem 'dm-rails'
gem 'dm-sqlite-adapter'
gem 'dm-mysql-adapter'
gem 'dm-migrations'
gem 'dm-types'
gem 'dm-validations'
gem 'dm-constraints'
gem 'dm-transactions'
gem 'dm-aggregates'
gem 'dm-timestamps'
gem 'dm-observer'
gem 'dm-core'
gem 'dm-do-adapter'
gem 'dm-active_model'

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

# run "bundle install"
#run "rails g authlogic:session user_session"

# create root path
generate :controller, "Welcome index"
route "map.root :controller => 'welcome'"

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
