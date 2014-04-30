module Symbiont
  module Accessor
    def reference_element(element, locator)
      driver.send(element, locator)
    end
  end
end
