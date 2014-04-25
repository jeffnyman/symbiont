require 'symbiont/version'
require 'symbiont/logging'
require 'symbiont/errors'
require 'symbiont/helpers'

require 'colorize'

require 'symbiont/platform'
require 'symbiont/assertions'
require 'symbiont/pages'

module Symbiont
  include Platform
  
  # @param caller [Class] the class including the framework
  def self.included(caller)
    caller.extend Symbiont::Assertion
    caller.send :include, Symbiont::Page

    Symbiont.trace("#{caller.class} #{caller} has attached the Symbiont.")
  end
end

def attach(mod=Symbiont)
  include mod
end
