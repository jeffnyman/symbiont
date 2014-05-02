module Symbiont
  module Page
    include Helpers

    def view
      no_url_is_provided if url.nil?
      driver.goto(url)
    end

    def has_correct_url?
      no_url_matches_is_provided if url_match.nil?
      !(driver.url =~ url_match).nil?
    end

    def has_correct_title?
      no_title_is_provided if page_title.nil?
      !(driver.title.match(page_title)).nil?
    end

    def url
      self.class.url
    end

    def url_match
      self.class.url_match
    end

    def page_title
      self.class.page_title
    end
  end
end
