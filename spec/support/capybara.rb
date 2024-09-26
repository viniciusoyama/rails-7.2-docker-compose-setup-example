require 'capybara/rails'
require "capybara/rspec"
require 'selenium-webdriver'

Capybara.server_host = '0.0.0.0'
Capybara.server_port = '3001'

Capybara.register_driver :remote_selenium do |app|
  options   = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--window-size=1320,830")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")
  selenium_url = "http://#{ENV['SELENIUM_REMOTE_HOST']}:4444/wd/hub"

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: selenium_url,
    options: options,
  )
end


Capybara.configure do |config|
  
  config.default_driver = :remote_selenium
  config.javascript_driver = :remote_selenium
  config.always_include_port = true

  config.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}"
end
