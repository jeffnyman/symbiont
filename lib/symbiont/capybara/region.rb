require 'capybara'

require 'symbiont/capybara/element'

module Symbiont
  class Region
    include Capybara::DSL
    extend Element

    attr_reader :region_element, :region_parent

    def initialize(region_parent, region_element)
      @region_parent = region_parent
      @region_element = region_element
    end

    private

    def find_first(*identifier)
      region_element.find(*identifier)
    end
  end
end
