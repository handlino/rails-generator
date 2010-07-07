gem 'handicraft_helper',  ">=1.1"

gem 'will_paginate',      ">=3.0.pre"
gem 'delayed_job'
gem 'paperclip'
gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'

RSPEC_VERSION = ">= 2.0.0.beta.9.1"

gem 'rspec',              RSPEC_VERSION, :group => [:test, :cucumber]
gem 'rspec-core',         RSPEC_VERSION, :group => [:test, :cucumber], :require => 'rspec/core'
gem 'rspec-expectations', RSPEC_VERSION, :group => [:test, :cucumber], :require => 'rspec/expectations'
gem 'rspec-mocks',        RSPEC_VERSION, :group => [:test, :cucumber], :require => 'rspec/mocks'
gem 'rspec-rails',        RSPEC_VERSION, :group => [:test, :cucumber]
gem "factory_girl_rails", ">= 1.0.0",    :group => [:test, :cucumber]

