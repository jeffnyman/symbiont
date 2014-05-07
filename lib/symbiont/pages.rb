module Symbiont
  module Page
    include Helpers

    def view
      no_url_is_provided if asserted_url.nil?
      driver.goto(asserted_url)
    end

    def has_correct_url?
      no_url_matches_is_provided if url_match.nil?
      !(driver.url =~ url_match).nil?
    end

    def has_correct_title?
      no_title_is_provided if asserted_title.nil?
      !(driver.title.match(asserted_title)).nil?
    end

    def asserted_url
      self.class.asserted_url
    end

    def url_match
      self.class.url_match
    end

    def asserted_title
      self.class.asserted_title
    end

    def url
      driver.url
    end

    def markup
      driver.html
    end

    def text
      driver.text
    end

    def title
      driver.title
    end

    def visit(url)
      driver.goto(url)
    end

    def screenshot(file)
      driver.wd.save_screenshot(file)
    end

    def run_script(script, *args)
      driver.execute_script(script, *args)
    end

    def get_cookie(name)
      for cookie in driver.cookies.to_a
        if cookie[:name] == name
          return cookie[:value]
        end
      end
      nil
    end

    def clear_cookies
      driver.cookies.clear
    end

    def refresh
      driver.refresh
    end

    alias_method :current_url, :url
    alias_method :page_url, :url
    alias_method :html, :markup
    alias_method :page_text, :text
    alias_method :page_title, :title
    alias_method :navigate_to, :visit
    alias_method :goto, :visit
    alias_method :save_screenshot, :screenshot
    alias_method :execute_script, :run_script
    alias_method :remove_cookies, :clear_cookies
    alias_method :refresh_page, :refresh
  end
end
