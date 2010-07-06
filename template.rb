
# remove unused files
run "rm README"
run "rm public/index.html"
run "rm -f public/javascripts/*"
run "rm -f publuc/images/*"

# install unit test framework

gem 'rspec-rails',  :group => :test
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

gem 'will_paginate'
gem 'action_mailer_optional_tls'
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

# layout

layout = <<-LAYOUT
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>#{app_name}</title>
    <%= stylesheet_link :all %>
</head>
<!--[if lt IE 7 ]>
<body class="ie6 yui-skin-sam"><![endif]-->
<!--[if gte IE 7 ]>
<body class="ie yui-skin-sam"><![endif]-->
<!--[if !IE]>-->
<body class="yui-skin-sam">
<!--<![endif]-->
    <div id="container">
        <div id="header">
            <div class="container_16">
                <h1><a href="/">#{app_name}</a></h1>
                <%= render :partial => '/common/user_menu' if you_are_user %>
                <%= render :partial => '/common/customer_menu' if you_are_customer %>
            </div>
        </div>
        <div id='stickies'>
       <% flash.each do |type, msg| %>
          <div style='stickie_<%=type%>'>
            <%=h msg %>
          </div>
        <% end %>
        </div>

        <% if @content_for_box %>
            <div id="box"  class="container_16 cleafix">
                <%= yield(:box) %>
            </div>
        <% else %>
            <div id="wrapper" class="container_16">
                <% if @content_for_sidebar %>
                <div id="main" class="grid_11 alpha">
                    <%= yield %>
                </div>
                <div id="sidebar" class="grid_5 omega">
                    <%= yield :sidebar %>
                </div>
                <% else %>
                <div id="main">
                    <%= yield %>
                </div>
                <% end %>
                <div class="clear"></div>
            </div>
        <% end %>
        <div class="container_16 clearfix">
            <%= yield_or_default(yield(:footer), render('welcome/footer') )%>
        </div>
    </div>

    <%= javascript_include_tag :default %>
    <%= yield(:page_specific_javascript) %>
</body>
</html>
LAYOUT

remove_file "app/views/layouts/application.html.erb"
create_file "app/views/layouts/application.html.erb", layout

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

DOCS

log docs

generate :controller, "welcome index"
route "map.root :controller => 'welcome'"


