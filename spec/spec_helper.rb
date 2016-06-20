require "simplecov"
SimpleCov.start "rails"

ENV["RAILS_ENV"] ||= 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require "rspec/rails"
require "shoulda-matchers"
require "ffaker"

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!

  # config.backtrace_exclusion_patterns = [/gems\/activesupport/, /gems\/actionpack/, /gems\/rspec/]
  config.color = true
  config.fail_fast = ENV['FAIL_FAST'] || false

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.use_transactional_fixtures = false

  config.mock_with :rspec do |mock|
    mock.syntax = [:should, :expect]
  end
end