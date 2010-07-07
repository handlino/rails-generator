# remove unused files. The default Gemfile is unwanted.
remove_file 'Gemfile'
create_file 'Gemfile'

RAILS_VERSION = '~> 3.0.0.beta4'
gem 'activesupport',      RAILS_VERSION, :require => 'active_support'
gem 'actionpack',         RAILS_VERSION, :require => 'action_pack'
gem 'actionmailer',       RAILS_VERSION, :require => 'action_mailer'
gem 'railties',           RAILS_VERSION, :require => 'rails'

gem 'dm-rails'
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

# http://datamapper.org/templates/rails/config.rb
gsub_file 'config/application.rb', /require 'rails\/all'/ do
<<-RUBY
## Pick the frameworks you want:
require 'action_controller/railtie'
require 'dm-rails/railtie'
# require 'action_mailer/railtie'
# require 'active_resource/railtie'
# require 'rails/test_unit/railtie'
RUBY
end

gsub_file 'config/environments/development.rb', /config.action_mailer.raise_delivery_errors = false/ do
  "# config.action_mailer.raise_delivery_errors = false"
end

gsub_file 'config/environments/test.rb', /config.action_mailer.delivery_method = :test/ do
  "# config.action_mailer.delivery_method = :test"
end
##############################################################

app_name = app_path.split('/').last.downcase
create_file 'config/database.yml.example' do
<<-YAML
defaults: &defaults
  adapter: mysql
  username: root
  password:
  host: localhost

development:
  <<: *defaults
  database: #{app_name}_development
test:
  <<: *defaults
  database: #{app_name}_test
production:
  <<: *defaults
  database: #{app_name}_production
YAML
end
run "cp config/database.yml.example config/database.yml"

inject_into_file  'app/controllers/application_controller.rb',
                  "require 'dm-rails/middleware/identity_map'\n",
                  :before => 'class ApplicationController'

inject_into_class 'app/controllers/application_controller.rb',
                  'ApplicationController',
                  "  use Rails::DataMapper::Middleware::IdentityMap\n"
