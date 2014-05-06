require 'watir-webdriver'

require 'symbiont/version'
require 'symbiont/logging'
require 'symbiont/errors'
require 'symbiont/helpers'

require 'colorize'

#require 'symbiont/platform'
require 'symbiont/assertions'
require 'symbiont/pages'
require 'symbiont/elements'
require 'symbiont/accessor'
require 'symbiont/factory'

module Symbiont
  #include Platform
  
  # @param caller [Class] the class including the framework
  def self.included(caller)
    caller.extend Symbiont::Assertion
    caller.extend Symbiont::Element
    
    caller.send :include, Symbiont::Page
    caller.send :include, Symbiont::Accessor

    Symbiont.trace("#{caller.class} #{caller} has attached the Symbiont.")
  end

  # @return [Object] browser driver reference
  attr_reader :driver

  # @param driver [Object] a tool driver instance
  def initialize(driver)
    Symbiont.trace("Dialect attached to driver:\n\t#{driver.inspect}")
    @driver = driver
  end
end

def attach(mod=Symbiont)
  include mod
end
