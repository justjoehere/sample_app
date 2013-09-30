source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=railstutorial_rails_4_0
#####Pick up at Excercise SPork!!!
require 'rbconfig' #for use with guard
gem 'rails', '4.0.0'
gem 'bootstrap-sass', '2.3.2.0'
gem 'bcrypt-ruby', '3.1.2'
#Had to do this http://stackoverflow.com/questions/18541062/issues-using-bcrypt-3-0-1-with-ruby2-0-on-windows
gem 'faker', '1.1.2'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'

gem 'annotate', '2.5.0', group: :development

group :development, :test do
  gem 'sqlite3','1.3.8'    #v1.3.5 and 1.3.7 have an issue with R2.0.0 and 1.9.3
  gem 'rspec-rails'#, '2.13.1'
  # The following optional lines are part of the advanced setup.
  gem 'guard-rspec', '2.5.0'
  gem 'wdm', '>= 0.1.0' if RbConfig::CONFIG['target_os'] =~ /mswin|mingw/i      #for use with guard
  gem 'spork-rails', '4.0.0'#github: 'sporkrb/spork-rails'
  gem 'guard-spork', '1.5.0'
  gem 'childprocess', '0.3.6'
end

group :test do
  gem 'selenium-webdriver', '2.0.0'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.0'
  gem 'cucumber-rails', '1.4.0', :require => false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'rubyzip', '<1.0.0' #See http://stackoverflow.com/questions/18555992/bundle-exec-rspec-spec-requests-static-pages-spec-rb-from-hartls-tutorial-isnt

  # Uncomment this line on OS X.
  # gem 'growl', '1.0.3'

  # Uncomment these lines on Linux.
  # gem 'libnotify', '0.8.0'

  # Uncomment these lines on Windows.
  gem 'rb-notifu', '0.0.4'
  #gem 'win32console', '1.3.2' This is depricated, should do ansicon-but ansicon crashes ruby
end

gem 'sass-rails', '4.0.0'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.0'
gem 'jquery-rails', '2.2.1'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end