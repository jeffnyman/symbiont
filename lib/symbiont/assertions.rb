module Symbiont
  module Assertion
    include Helpers

    def url_is(url = nil)
      url_is_empty if url.nil? || url.empty?
      @url = url
    end

    def url_matches(pattern = nil)
      url_match_is_empty if pattern.nil?
      url_match_is_empty if pattern.is_a?(String) && pattern.empty?
      @url_match = pattern
    end

    def title_is(title = nil)
      title_is_empty if title.nil? || title.empty?
      @title = title
    end

    def asserted_url
      @url
    end

    def url_match
      @url_match
    end

    def asserted_title
      @title
    end
  end
end
