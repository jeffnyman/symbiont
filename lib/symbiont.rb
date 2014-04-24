require 'symbiont/version'
require 'symbiont/errors'
require 'symbiont/helpers'

require 'colorize'

module Symbiont
  # @param caller [Class] the class including the framework
  def self.included(caller)
    caller.extend Symbiont::Assertion
  end
end

def attach(mod=Symbiont)
  include mod
end

require 'symbiont/assertions'
