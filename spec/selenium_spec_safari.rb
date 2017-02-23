# frozen_string_literal: true
require 'spec_helper'
require 'selenium-webdriver'
require 'shared_selenium_session'


opts = {
  browser: :safari
}
opts[:driver_path] = '/Applications/Safari Technology Preview.app/Contents/MacOS/safaridriver' if ENV['STP']

Capybara.register_driver :selenium_safari do |app|
  Capybara::Selenium::Driver.new(app, opts)
end

module TestSessions
  Safari = Capybara::Session.new(:selenium_safari, TestApp)
end

skipped_tests = %i[response_headers status_code trigger]
skipped_tests << :windows # safari driver doesn't support multiple windows/tabs
skipped_tests << :modals # Hang tests

Capybara::SpecHelper.run_specs TestSessions::Safari, "selenium_safari", capybara_skip: skipped_tests

RSpec.describe "Capybara::Session with Safari" do
  include Capybara::SpecHelper
  include_examples  "Capybara::Session", TestSessions::Safari, :selenium_safari
end
