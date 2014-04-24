require 'symbiont/version'
require 'symbiont/errors'
require 'symbiont/helpers'

require 'colorize'

require 'symbiont/assertions'
require 'symbiont/pages'

module Symbiont
  # @param caller [Class] the class including the framework
  def self.included(caller)
    caller.extend Symbiont::Assertion
    caller.send :include, Symbiont::Page
  end
end

def attach(mod=Symbiont)
  include mod
end
