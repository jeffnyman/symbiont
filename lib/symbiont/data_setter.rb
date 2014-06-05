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
      element = self.send("#{key}")
      self.call_method_chain("#{key}.set", value)     if element.class == Watir::TextField
      self.call_method_chain("#{key}.set")            if element.class == Watir::Radio
      self.call_method_chain("#{key}.select", value)  if element.class == Watir::Select

      return self.call_method_chain("#{key}.check")   if element.class == Watir::CheckBox and value
      return self.call_method_chain("#{key}.uncheck") if element.class == Watir::CheckBox
    end

    private

    def object_enabled_for(key)
      web_element = self.send("#{key}")
      web_element.enabled? and web_element.visible?
    end
  end
end
