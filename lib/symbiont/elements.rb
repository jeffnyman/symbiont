module Symbiont
  # Calls the Watir module to get a list of the factory methods that
  # Watir uses to reference and access web objects.
  #
  # @return [Array] factory method list
  def self.elements
    unless @elements
      @elements = Watir::Container.instance_methods
      # @elements.delete(:extract_selector)
    end
    @elements
  end

  def self.settable
    @settable ||= [:text_field, :file_field, :textarea]
  end

  def self.selectable
    @selectable ||= [:select_list]
  end

  def self.settable?(element)
    settable.include? element.to_sym
  end

  def self.selectable?(element)
    selectable.include? element.to_sym
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
        define_set_accessor(identifier, locator, element, &context) if Symbiont.settable?(element)
        define_select_accessor(identifier, locator, element, &context) if Symbiont.selectable?(element)
      end
    end

    private

    # Defines an accessor method for an element that allows the friendly
    # name of the element to be proxied to a Watir element object that
    # corresponds to the element type.
    #
    # @param identifier [Symbol] friendly name of element definition
    # @param locator [Hash] locators for referencing the element
    # @param element [Symbol] name of Watir-based object
    # @param block [Proc] a context block
    #
    # @example
    # This element definition:
    #   text_field :weight, id: 'wt', index: 0
    #
    # passed in like this:
    #   :weight, {:id => 'wt', :index => 0}, :text_field
    #
    # This allows access like this:
    #   @page.weight.set '200'
    #
    # Access could also be done this way:
    #   @page.weight(id: 'wt').set '200'
    #
    # The second approach would lead to the *values variable having
    # an array like this: [{:id => 'wt'}].
    #
    # A third approach would be to utilize one element definition
    # within the context of another. Consider the following element
    # definitions:
    #   article :practice, id: 'practice'
    #
    #   a :page_link do |text|
    #     practice.a(text: text)
    #   end
    #
    # These could be utilized as such:
    #   on_view(Practice).page_link('Click Me').click
    #
    # This approach would lead to the *values variable having
    # an array like this: ["Click Me"].
    def define_element_accessor(identifier, locator, element, &block)
      define_method "#{identifier}".to_sym do |*values|
        if block_given?
          instance_exec(*values, &block)
        else
          reference_element(element, locator)
        end
      end
    end

    # Defines an accessor method for an element that allows the value of
    # the element to be set via appending an "=" to the friendly name
    # (identifier) of the element passed in.
    #
    # @param identifier [Symbol] friendly name of element definition
    # @param locator [Hash] locators for referencing the element
    # @param element [Symbol] name of Watir-based object
    # @param block [Proc] a context block
    #
    # @example
    # This element definition:
    #   text_field :weight, id: 'wt'
    #
    # Can be accessed in two ways:
    #    @page.weight.set '200'
    #    @page.weight = '200'
    #
    # The second approach would lead to the *values variable having
    # an array like this: ['200']. The first approach would be
    # handled by define_element_accessor instead.
    def define_set_accessor(identifier, locator, element, &block)
      define_method "#{identifier}=".to_sym do |*values|
        accessor =
        if block_given?
          instance_exec(&block)
        else
          reference_element(element, locator)
        end

        if accessor.respond_to?(:set)
          accessor.set(*values)
        else
          accessor.send_keys(*values)
        end
      end
    end

    # Defines an accessor method for an element that allows the value of
    # the element to be selected via appending an "=" to the friendly
    # name (identifier) of the element passed in.
    #
    # @param identifier [Symbol] friendly name of element definition
    # @param locator [Hash] locators for referencing the element
    # @param element [Symbol] name of Watir-based object
    # @param block [Proc] a context block
    #
    # @example
    # This element definition:
    #   select_list :city, id: 'city'
    #
    # Can be accessed in two ways:
    #    @page.city.select 'Chicago'
    #    @page.city = 'Chicago'
    #
    # The second approach would lead to the *values variable having
    # an array like this: ['City']. The first approach would be
    # handled by define_element_accessor instead.
    def define_select_accessor(identifier, locator, element, &block)
      define_method "#{identifier}=".to_sym do |*values|
        if block_given?
          instance_exec(&block).select(*values)
        else
          reference_element(element, locator).select(*values)
        end
      end
    end

    # Returns the identifier and locator portions of an element definition.
    #
    # @param signature [Array] full element definition
    # @return [String] identifier and locator portions
    def parse_signature(signature)
      # return signature.shift, signature.shift
      [signature.shift, signature.shift]
    end

    # Returns the block or proc that serves as a context for an element
    # definition.
    #
    # @param locator [Array] locators from element definition
    # @param block [Proc] a context block
    # @return [Proc] the context block or nil if there is no procedure
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
