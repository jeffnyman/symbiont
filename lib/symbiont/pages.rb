module Symbiont
  module Page
    include Helpers

    def view
      no_url_is_provided if url.nil?
      platform.view(url)
    end

    def has_correct_url?
      no_url_matches_is_provided if url_match.nil?
      !(platform.url =~ url_match).nil?
    end

    def has_correct_title?
      no_title_is_provided if title.nil?
      !(platform.title.match(title)).nil?
    end

    def url
      self.class.url
    end

    def url_match
      self.class.url_match
    end

    def title
      self.class.title
    end
  end
end
