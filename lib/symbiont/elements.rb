module Symbiont
  def self.elements
    @elements = [:article, :text_field, :button, :a, :link, :iframe]
  end

  module Element
    Symbiont.elements.each do |element|
      define_method element do |*signature, &block|
        identifier, locator = parse_signature(signature)
        context = context_from_signature(locator, &block)
        define_element_accessor(identifier, locator, element, &context)
      end
    end

    private

    # @param identifier [String] friendly name of element definition
    # @param locator [String] name of Watir-based object
    # @param element [String] the type of the element
    # @param block [Object] a context block
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
