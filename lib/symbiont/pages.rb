require 'symbiont/ready'

module Symbiont
  module Pages
    include Helpers

    def view(&block)
      no_url_is_provided if asserted_url.nil?
      browser.goto(asserted_url)
      when_ready(&block) if block_given?
      self
    end

    def perform
      view
    end

    def has_correct_url?
      no_url_matches_is_provided if url_match.nil?
      !(browser.url =~ url_match).nil?
    end

    def has_correct_title?
      no_title_is_provided if asserted_title.nil?
      !(browser.title.match(asserted_title)).nil?
    end

    def verified?
      has_correct_url?
      has_correct_title?
    end

    def displayed?
      has_correct_url?
    end

    def secure?
      !url.match(/^https/).nil?
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
      browser.url
    end

    def markup
      browser.html
    end

    def text
      browser.text
    end

    def title
      browser.title
    end

    def visit(url)
      browser.goto(url)
    end

    def screenshot(file)
      browser.wd.save_screenshot(file)
    end

    def run_script(script, *args)
      browser.execute_script(script, *args)
    end

    def get_cookie(name)
      browser.cookies.to_a.each do |cookie|
        return cookie[:value] if cookie[:name] == name
      end
      nil
    end

    def clear_cookies
      browser.cookies.clear
    end

    def refresh
      browser.refresh
    end

    # @return [String] the message contained in the alert message box
    def will_alert
      yield
      value = nil
      if browser.alert.exists?
        value = browser.alert.text
        browser.alert.ok
      end
      value
    end

    # @param response [Boolean] true to accept confirmation, false to cancel it
    # @return [String] the message contained in the confirmation message box
    def will_confirm(response)
      yield
      value = nil
      if browser.alert.exists?
        value = browser.alert.text
        response ? browser.alert.ok : browser.alert.close
      end
      value
    end

    # @param response [String] the value to be used in the prompt
    # @return [Hash] :message for the prompt message, :default_value for
    # the value that the prompt had before the response was applied
    def will_prompt(response)
      cmd = "window.prompt = function(text, value) \
        {window.__lastWatirPrompt = {message: text, default_value: value}; \
        return '#{response}';}"
      browser.wd.execute_script(cmd)
      yield
      result = browser.wd.execute_script('return window.__lastWatirPrompt')
      result && result.dup.each_key { |k| result[k.to_sym] = result.delete(k) }
      result
    end

    # Used to identify a web element or action on a web element as existing
    # within an enclosing window object. The window can be referenced using
    # either the title attribute of the window or a direct URL. The URL does
    # not have to be the entire URL; it can just be a page name.
    #
    # @param locator [Hash] the :title or :url of the window
    # @param block [Proc] any code that should be executed as an
    # action on or within the window
    def within_window(locator, &block)
      identifier = { locator.keys.first => /#{Regexp.escape(locator.values.first)}/ }
      browser.window(identifier).use(&block)
    end

    # Used to identify a web element as existing within an enclosing object
    # like a modal dialog box. What this does is override the normal call to
    # showModalDialog and opens a window instead. In order to use this new
    # window, you have to attach to it.
    def within_modal
      convert_modal_to_window = %{
        window.showModalDialog = function(sURL, vArguments, sFeatures) {
          window.dialogArguments = vArguments;
          modalWin = window.open(sURL, 'modal', sFeatures);
          return modalWin;
        }
      }
      browser.execute_script(convert_modal_to_window)
      yield if block_given?
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
    alias_method :select_window, :within_window
    alias_method :attach_to, :within_window
  end
end
