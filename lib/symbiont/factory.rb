module Symbiont
  module Factory
    include Workflow

    # Creates a definition context for actions. If an existing context
    # exists, that context will be re-used.
    #
    # @param definition [Class] the name of a definition class
    # @param visit [Boolean] true if the context needs to be called into view
    # @param block [Proc] logic to execute in the context of the definition
    # @return [Object] instance of the definition
    def on(definition, visit=false, &block)
      if @page.kind_of?(definition)
        block.call @page if block
        return @page
      end

      if @context.kind_of?(definition)
        block.call @context if block

        unless @page.kind_of?(definition)
          @page = @context
        end

        return @context
      end

      @page = definition.new(@browser)
      @page.view if visit

      @page.has_correct_url? if @page.respond_to?(:url_matches)
      @page.has_correct_title? if @page.respond_to?(:title_is)

      @model = @page

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
      @model = nil

      if @context.kind_of?(definition)
        @context = nil
      end
      
      on(definition, &block)
    end

    # Creates a definition context for actions. If an existing context
    # exists, that context will be re-used. This also sets a context that
    # will be used for that definition even if the active definition
    # changes.
    #
    # @param definition [Class] the name of a definition class
    # @param block [Proc] logic to execute within the context of the definition
    # @return [Object] instance of the definition
    def on_set(definition, &block)
      on(definition, &block)
      @context = @page
    end
  end
end
