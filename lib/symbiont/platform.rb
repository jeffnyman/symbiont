module Symbiont
  module Platform
    # @return [Object] platform reference
    attr_reader :platform

    # @return [Object] browser driver reference
    attr_reader :driver

    # @param driver [Object] a tool driver instance
    def initialize(driver)
      Symbiont.trace("Dialect attached to driver:\n\t#{driver.inspect}")
      @driver = driver
      establish_platform(driver)
    end

    private

    # @param driver [Object] a browser instance with a tool driver
    # @return [Object] a platform object to execute tests against
    def establish_platform(driver)
      @platform = get_platform(driver)
      Symbiont.trace("Dialect platform object:\n\t#{@platform.inspect}")
      @platform
    end

    # @param driver [Object] the browser to establish the platform for
    # @return [Object] a platform object to execute tests against
    def get_platform(driver)
      require 'symbiont/platform/watir_webdriver'
      require 'symbiont/platform/selenium_webdriver'

      return Platform::SeleniumWebDriver.new(driver) if driver.is_a?(::Selenium::WebDriver::Driver)
      return Platform::WatirWebDriver.new(driver)    if driver.is_a?(::Watir::Browser)

      unable_to_create_platform(driver)
    end
  end
end
