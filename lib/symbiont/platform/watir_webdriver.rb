module Symbiont
  module Platform
    class WatirWebDriver
      def initialize(driver)
        @driver = driver
      end

      def view(url)
        @driver.goto(url)
      end

      def url
        @driver.url
      end

      def title
        @driver.title
      end
    end
  end
end
