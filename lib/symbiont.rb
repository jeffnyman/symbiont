require 'watir-webdriver'
require 'watir-scroll'
require 'watir-dom-wait'

require 'symbiont/version'
require 'symbiont/errors'
require 'symbiont/helpers'

require 'colorize'

require 'symbiont/assertions'
require 'symbiont/pages'
require 'symbiont/elements'
require 'symbiont/accessor'
require 'symbiont/factory'

require 'symbiont/data_reader'
require 'symbiont/data_setter'
require 'symbiont/data_builder'

require 'symbiont/service_objects'

require 'symbiont/capybara/page'

module Symbiont
  # @param caller [Class] the class including the framework
  def self.included(caller)
    caller.extend Symbiont::Assertion
    caller.extend Symbiont::Element
    caller.send :include, Symbiont::Pages
    caller.send :include, Symbiont::Accessor
    caller.send :include, Symbiont::DataSetter
    caller.send :include, Symbiont::DataBuilder
    Symbiont.trace("#{caller.class} #{caller} has attached the Symbiont.")
  end

  def self.trace(message, level = 1)
    puts '*' * level + " #{message}" if ENV['SYMBIONT_TRACE'] == 'on'
  end

  def self.browser=(browser)
    @browser = browser
  end

  def self.browser
    @browser
  end

  def self.version
    """
Symbiont v#{Symbiont::VERSION}
Watir-WebDriver: #{Gem.loaded_specs['watir-webdriver'].version}
Selenium-WebDriver: #{Gem.loaded_specs['selenium-webdriver'].version}
Capybara: #{Gem.loaded_specs['capybara'].version}
    """
  end

  # @return [Object] browser driver reference
  attr_reader :browser

  # @param browser [Object] a tool driver instance
  def initialize(browser = nil)
    Symbiont.trace("Symbiont attached to browser:\n\t#{browser.inspect}")

    @browser = Symbiont.browser unless Symbiont.browser.nil?
    @browser = browser if Symbiont.browser.nil?

    initialize_page if respond_to?(:initialize_page)
    initialize_activity if respond_to?(:initialize_activity)
  end

  def self.set_browser(app = :firefox, *args)
    @browser = Watir::Browser.new(app, *args)
    Symbiont.browser = @browser
  end
end

def attach(mod = Symbiont)
  include mod
end

class Object
  def call_method_chain(method_chain, arg = nil)
    return self if method_chain.empty?
    method_chain.split('.').inject(self) do |o, m|
      if arg.nil?
        o.send(m.intern)
      else
        o.send(m.intern, arg)
      end
    end
  end
end

module Watir
  class CheckBox
    alias_method :check, :set
    alias_method :uncheck, :clear
    alias_method :checked?, :set?
  end
end

module Watir
  class Radio
    alias_method :choose, :set
    alias_method :chosen?, :set?
  end
end
