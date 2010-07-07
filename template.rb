apply File.dirname(__FILE__) + '/common/gems.rb'

# remove unused files
run "rm README"
run "rm public/index.html"
run "rm -f public/javascripts/*"
run "rm -f publuc/images/*"

# create root path

generate :controller, "Welcome index"
route "map.root :controller => 'welcome'"

application <<-GENERATORS
    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
GENERATORS


run "bundle install"
run "rails g authlogic:session user_session"

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
