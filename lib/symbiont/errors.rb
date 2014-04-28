module Symbiont
  module Errors
    class NoUrlForDefinition < StandardError; end
    class NoUrlMatchForDefinition < StandardError; end
    class NoTitleForDefinition < StandardError; end
    class UnableToCreatePlatform < StandardError; end
  end
end
