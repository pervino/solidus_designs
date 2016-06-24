# encoding: UTF-8

# UPGRADE NOTES
# ANY changes made to this gem will *NOT* be reflected on gemfury
# unless you bump the version. Gemfury does not rebuild gems of the
# same version. So either delete that version in gemfury prior to
# pushing or bump the version.
#
# To push alternate branches to gemfury you have to
# git push fury -f branch:master
# Gemfury Only builds from master branch.
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_designs'
  s.version     = '0.1.11'
  s.summary     = 'Add customizations to items (shipments and line items)'
  s.description = 'Provides customization options to line items'
  s.required_ruby_version = '>= 2.1.0'

  s.author    = ['Anthony Daddeo']
  s.email     = ['anthony@personalwine.com']
  s.homepage  = 'http://www.personalwine.com'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'solidus_core', '~> 1.3'
  s.add_dependency 'solidus_api', '~> 1.3'
  s.add_dependency 'solidus_backend', '~> 1.3'
  s.add_dependency 'solidus_customizations'
  s.add_dependency 'solidus_auth_devise'
  s.add_dependency 'acts-as-taggable-on', '~> 3.4'
  s.add_dependency 'paranoia', '~> 2.1'
  s.add_dependency 'delayed_job'
  s.add_dependency 'aws-sdk', '~> 1.5'
  s.add_dependency 'paperclip', '~> 4.2.0'
  s.add_dependency 'warden'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
end
