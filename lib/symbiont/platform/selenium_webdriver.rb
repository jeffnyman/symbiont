module Symbiont
  module Platform
    class SeleniumWebDriver
      def initialize(driver)
        @driver = driver
      end

      def view(url)
        @driver.navigate.to(url)
      end

      def url
        @driver.current_url
      end

      def title
        @driver.title
      end
    end
  end
end
