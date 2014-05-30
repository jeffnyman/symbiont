require 'watir-webdriver'

require 'symbiont/version'
require 'symbiont/errors'
require 'symbiont/helpers'

require 'colorize'

require 'symbiont/assertions'
require 'symbiont/pages'
require 'symbiont/elements'
require 'symbiont/accessor'
require 'symbiont/factory'

module Symbiont
  
  # The included callback is used to provide the core functionality of the
  # library to any class or module that includes the Symbiont library. The
  # calling class or module is extended with logic that the library makes
  # available as class methods. Any such class or module becomes a page or
  # activity definition. The class methods allow assertions and element
  # defintions to be defined.
  #
  # @param caller [Class] the class including the framework
  def self.included(caller)
    caller.extend Symbiont::Assertion
    caller.extend Symbiont::Element
    
    caller.send :include, Symbiont::Page
    caller.send :include, Symbiont::Accessor

    Symbiont.trace("#{caller.class} #{caller} has attached the Symbiont.")
  end

  def self.trace(message, level = 1)
    puts '*' * level + " #{message}" if ENV['SYMBIONT_TRACE'] == 'on'
  end

  # @return [Object] browser driver reference
  attr_reader :driver

  # @param driver [Object] a tool driver instance
  def initialize(driver)
    Symbiont.trace("Symbiont attached to driver:\n\t#{driver.inspect}")
    @driver = driver

    initialize_page if respond_to?(:initialize_page)
    initialize_activity if respond_to?(:initialize_activity)
  end
end

def attach(mod=Symbiont)
  include mod
end

def symbiont_browser(browser=:firefox)
  @driver = Watir::Browser.new browser
end

alias :symbiont_browser_for :symbiont_browser
