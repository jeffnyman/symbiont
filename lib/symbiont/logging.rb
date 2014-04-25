module Symbiont
  def self.trace(message, level = 1)
    puts '*' * level + " #{message}" if ENV['SYMBIONT_TRACE'] == 'on'
  end
end
