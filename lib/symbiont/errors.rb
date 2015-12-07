module Symbiont
  module Errors
    class NoUrlForDefinition < StandardError; end
    class NoUrlMatchForDefinition < StandardError; end
    class NoTitleForDefinition < StandardError; end
    class ElementVisibleTimeout < StandardError; end
    class ElementNonVisibleTimeout < StandardError; end
    class PageNotValidatedError < StandardError; end

    class PageURLFromFactoryNotVerified < StandardError
      def message
        'The page URL was not verified during a factory setup.'
      end
    end

    class PageTitleFromFactoryNotVerified < StandardError
      def message
        'The page title was not verified during a factory setup.'
      end
    end
  end
end
