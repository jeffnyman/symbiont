module Symbiont
  module Factory

    # Creates a definition context for actions. If an existing context
    # exists, that context will be re-used.
    #
    # @param definition [Class] the name of a definition class
    # @param visit [Boolean] true if the context needs to be called into view
    # @param block [Proc] logic to execute in the context of the definition
    # @return [Object] instance of the definition
    def on(definition, visit=false, &block)
      if @active.kind_of?(definition)
        block.call @active if block
        return @active
      end

      if @context.kind_of?(definition)
        block.call @context if block
        return @context
      end

      @active = definition.new(@driver)
      @active.view if visit == true
      block.call @active if block

      @active
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
      @active = nil

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
      @context = @active
      @active
    end
  end
end
