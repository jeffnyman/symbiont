require 'capybara'

require 'symbiont/capybara/element'

module Symbiont
  class Page
    include Capybara::DSL
    extend Element

    class << self
      attr_reader :url

      def url_is(url)
        @url = url.to_s
      end

      def url_matches(url)
        @url_matcher = url
      end

      def url_matcher
        @url_matcher || url
      end
    end

    def view
      location = url
      fail Symbiont::Errors::NoUrlForDefinition if location.nil?
      visit url
    end

    def perform(*args)
      view(*args)
      self
    end

    def url
      self.class.url
    end

    def url_matcher
      self.class.url_matcher
    end

    def displayed?
      fail Symbiont::Errors::NoUrlMatchForDefinition if url_matcher.nil?
      true
    end

    def secure?
      !current_url.match(/^https/).nil?
    end

    private

    def find_first(*identifier)
      find(*identifier)
    end

    def find_all(*identifier)
      all(*identifier)
    end

    def element_exists?(*identifier)
      has_selector?(*identifier)
    end

    def element_does_not_exist?(*identifier)
      has_no_selector?(*identifier)
    end
  end
end
