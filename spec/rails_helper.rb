require 'simplecov'
SimpleCov.start 'rails' do
  minimum_coverage 100
end

ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'

abort('The Rails environment is running in production mode!') if Rails.env.production?

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.include RequestSpecHelper, type: :request

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.filter_run show_in_doc: true if ENV['APIPIE_RECORD']
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end
