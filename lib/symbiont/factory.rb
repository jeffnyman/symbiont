module Symbiont
  module Factory
    # Creates a definition context for actions. If an existing context
    # exists, that context will be re-used.
    #
    # @param definition [Class] the name of a definition class
    # @param visit [Boolean] true if the context needs to be called into view
    # @param block [Proc] logic to execute in the context of the definition
    # @return [Object] instance of the definition
    def on(definition, visit = false, &block)
      unless @page.is_a?(definition)
        @page = definition.new(@browser) if @browser
        @page = definition.new unless @browser
        @page.view if visit
      end

      if @page.class.instance_variable_get(:@url_match)
        raise Symbiont::Errors::PageURLFromFactoryNotVerified unless @page.has_correct_url?
      end

      if @page.class.instance_variable_get(:@title)
        raise Symbiont::Errors::PageTitleFromFactoryNotVerified unless @page.has_correct_title?
      end

      block.call @page if block
      @page
    end

    alias_method :on_page, :on
    alias_method :while_on, :on

    # Creates a definition context for actions and establishes the
    # context for display.
    #
    # @param definition [Class] the name of a definition class
    # @param block [Proc] logic to execute in the context of the definition
    # @return [Object] instance of the definition
    def on_view(definition, &block)
      on(definition, true, &block)
    end

    alias_method :on_visit, :on_view

    # Creates a definition context for actions. Unlike the on() factory,
    # on_new will always create a new context and will never re-use an
    # existing one.
    #
    # @param definition [Class] the name of a definition class
    # @param block [Proc] logic to execute in the context of the definition
    # @return [Object] instance of the definition
    def on_new(definition, &block)
      @page = nil
      on(definition, &block)
    end
  end
end
