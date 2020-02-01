# frozen_string_literal: true

RSpec.configure do |config|
  # Tell Heroku where to find Chrome binary
  # @see https://devcenter.heroku.com/articles/heroku-ci-browser-and-user-acceptance-testing-uat
  # @see https://github.com/heroku/heroku-buildpack-google-chrome
  # @see https://github.com/titusfortner/webdrivers/wiki/Heroku-buildpack-google-chrome
  if ENV['CI']
    require 'webdrivers'

    Selenium::WebDriver::Chrome.path = ENV['GOOGLE_CHROME_SHIM'] if ENV['GOOGLE_CHROME_SHIM'].present?
    Selenium::WebDriver.for :chrome
  end

  # system tests configs
  config.before(:all, type: :system) do
    # Silencing the puma bootup output
    Capybara.server = :puma, { Silent: true }
  end

  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome
  end

  Capybara.default_max_wait_time = 5
end

# Monkey patch for screenshots not being taken
# @see https://github.com/mattheworiordan/capybara-screenshot/issues/225
require 'action_dispatch/system_testing/test_helpers/setup_and_teardown'
::ActionDispatch::SystemTesting::TestHelpers::SetupAndTeardown.module_eval do
  def before_setup
    super
  end

  def after_teardown
    super
  end
end
