module Watir
  class Browser
    class Scroll

      def initialize(browser)
        @browser = browser
      end

      # @param [Symbol, Watir::Element, Array<Fixnum>] param
      def to(param)
        args = case param
          when :top, :start
            'window.scrollTo(0, 0);'
          when :center
            'window.scrollTo(document.body.scrollWidth / 2, document.body.scrollHeight / 2);'
          when :bottom, :end
            'window.scrollTo(0, document.body.scrollHeight);'
          when Watir::Element
            ['arguments[0].scrollIntoView();', param]
          when Array
            ['window.scrollTo(arguments[0], arguments[1]);', Integer(param[0]), Integer(param[1])]
          else
            raise ArgumentError, "Unable to determine how to scroll to: #{param}."
          end
        @browser.execute_script(*args)
      end

    end
  end
end
