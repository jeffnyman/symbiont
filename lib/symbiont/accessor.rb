module Symbiont
  module Accessor
    # @param element [Symbol] name of Watir-based object
    # @param locator [Hash] locators for referencing the element
    def reference_element(element, locator)
      browser.send(element, *locator)
    end
  end
end
