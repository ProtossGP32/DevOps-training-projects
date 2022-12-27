# Add requirements
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

# Add the DSL inside the test
include Capybara::DSL
# Configure Capybara to use Selenium as the webdriver
Capybara.app_host = "http://website"
Capybara.run_server = false
Capybara.register_driver :selenium do |app|
  # Define browser options
  options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << '--no-default-browser-check'
    opts.args << '--disable-dev-shm'
  end
  
  # Define remote capabilities
  remote_caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    "goog:chromeOptions": {
      args: %w[ no-default-browser-check disable-dev-shm ]
    }
  )

  Capybara::Selenium::Driver.new(
    app,
    # Define a remote browser as we are executing this within a Docker container
    browser: :remote,
    # Define the URL and port of the host that is executing the Docker container
    # - ENV variables provided by docker-compose.yml
    url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub",
    # Include the capabilities
    capabilities: [remote_caps, options]
  )
end
Capybara.default_driver = :selenium

# Write tests
describe "Example page render unit tests" do
  it "should show the Explore California logo" do
    visit('/')
    expect(page.has_selector? 'a.logo').to be true
  end
end
