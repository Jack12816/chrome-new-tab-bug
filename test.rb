# frozen_string_literal: true

require 'capybara'
require 'capybara/dsl'
require 'selenium/webdriver'

# Enable logging to file for the Chrome session
ENV['CHROME_LOG_FILE'] = "#{__dir__}/chrome.log"

# Specify default drivers
Capybara.javascript_driver = :chrome
Capybara.default_driver = :chrome

# Specify default settings
Capybara.default_max_wait_time = 5
Capybara.ignore_hidden_elements = true
Capybara.wait_on_first_by_default = true

# We test remote applications, lets tell this capybara
Capybara.run_server = false

# Register the Chrome driver on Capybara
Capybara.register_driver :chrome do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { binary: '/usr/bin/google-chrome-stable',
                     prefs: { plugins: { always_open_pdf_externally: true } } }
  )
  driver = Capybara::Selenium::Driver.new(app, browser: :chrome,
                                               desired_capabilities: caps)
  FileUtils.mkdir_p("#{__dir__}/Downloads")
  bridge = driver.browser.send(:bridge)
  bridge.http.call(:post,
                   "/session/#{bridge.session_id}/chromium/send_command",
                   cmd: 'Page.setDownloadBehavior',
                   params: {
                     behavior: 'allow',
                     downloadPath: "#{__dir__}/Downloads"
                   })
  driver
end

# Demonstrate the issue
include Capybara::DSL

visit("file://#{__dir__}/index.html")
find('a').click
visit("http://google.com")
sleep 60
