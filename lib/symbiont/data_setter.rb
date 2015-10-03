module Symbiont
  module DataSetter
    # @param data [Hash] the data to use
    def using(data)
      data.each do |key, value|
        use_data_with(key, value) if object_enabled_for(key)
      end
    end

    alias_method :using_data,   :using
    alias_method :use_data,     :using
    alias_method :using_values, :using
    alias_method :use_values,   :using

    def use_data_with(key, value)
      element = send("#{key}")
      set_and_select(element, value)
      check_and_uncheck(element, value)
    end

    private

    def set_and_select(element, value)
      call_method_chain("#{key}.set", value)     if element.class == Watir::TextField
      call_method_chain("#{key}.set")            if element.class == Watir::Radio
      call_method_chain("#{key}.select", value)  if element.class == Watir::Select
    end

    def check_and_uncheck(element, value)
      return call_method_chain("#{key}.check")   if element.class == Watir::CheckBox && value
      return call_method_chain("#{key}.uncheck") if element.class == Watir::CheckBox
    end

    def object_enabled_for(key)
      web_element = send("#{key}")
      web_element.enabled? && web_element.visible?
    end
  end
end
