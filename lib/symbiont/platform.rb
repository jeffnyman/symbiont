module Symbiont
  module Platform
    # @return [Object] browser driver reference
    attr_reader :driver

    # @param driver [Object] a tool driver instance
    def initialize(driver)
      Symbiont.trace("Dialect attached to driver:\n\t#{driver.inspect}")
      @driver = driver
    end
  end
end
