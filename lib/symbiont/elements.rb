module Symbiont
  # Calls the Watir module to get a list of the factory methods that
  # Watir uses to reference and access web objects.
  #
  # @return [Array] factory method list
  def self.elements
    unless @elements
      @elements = Watir::Container.instance_methods
    end
    @elements
  end

  module Element
    # Iterates through Watir factory methods. Each method is defined
    # as a method that can be called on a page class. This is what
    # allows element definitions to be created.
    Symbiont.elements.each do |element|
      define_method element do |*signature, &block|
        identifier, locator = parse_signature(signature)
        context = context_from_signature(locator, &block)
        define_element_accessor(identifier, locator, element, &context)
      end
    end

    private

    # @param identifier [String] friendly name of element definition
    # @param locator [Array] locators for referencing the element
    # @param element [String] name of Watir-based object
    # @param block [Proc] a context block
    #
    # @example
    #   enable, {:id => 'enableForm'}, checkbox
    def define_element_accessor(identifier, locator, element, &block)
      define_method "#{identifier}".to_sym do |*values|
        #puts "*** *values: #{values}"

        if block_given?
          instance_exec(*values, &block)
        else
          reference_element(element, locator)
        end
      end
    end

    # Returns the identifier and locator portions of an element definition.
    #
    # @param signature [Array] full element definition
    # @return [String] identifier and locator portions
    def parse_signature(signature)
      return signature.shift, signature.shift
    end

    # Returns the block or proc that serves as a context for an element
    # definition.
    #
    # @param locator [Array] locators from element definition
    # @param block [Proc] a context block
    def context_from_signature(*locator, &block)
      if block_given?
        block
      else
        context = locator.shift
        context.is_a?(Proc) && locator.empty? ? context : nil
      end
    end

  end
end
