RSpec.describe Symbiont::Pages do
  include_context :page
  include_context :element

  context 'automated page ready for any page definition' do
    it 'indicates true if displayed' do
      expect(watir_browser).to receive(:url).and_return('https://localhost:9292')
      allow(watir_definition).to receive(:displayed?).and_return true
      expect(watir_definition).to be_ready
    end

    it 'indicates false if not displayed' do
      expect(watir_browser).to receive(:url).and_return('https://localhost')
      allow(watir_definition).to receive(:displayed?).and_return false
      expect(watir_definition).not_to be_ready
    end
  end

  context 'a page definition being used - url' do
    it 'provides no default url' do
      expect(empty_definition.asserted_url).to be_nil
    end

    it 'provides a page url with the url_is assertion' do
      expect(watir_definition).to respond_to :asserted_url
      expect(watir_definition.asserted_url).to eq('http://localhost:9292')
    end

    it 'does not view a page if the url_is assertion has not been set' do
      expect { empty_definition.view }.to raise_error Symbiont::Errors::NoUrlForDefinition
    end
  end

  context 'a page definition being used - url match' do
    it 'provides no default url matcher' do
      expect(empty_definition.url_match).to be_nil
    end

    it 'provides a url matcher with the url_matches assertion' do
      expect(watir_definition).to respond_to :url_match
      expect(watir_definition.url_match).to eq(/:\d{4}/)
    end

    it 'does not verify a url if the url_matches assertion has not been set' do
      expect { empty_definition.has_correct_url? }.to raise_error Symbiont::Errors::NoUrlMatchForDefinition
    end
  end

  context 'a page definition being used - title' do
    it 'provides no default title' do
      expect(empty_definition.asserted_title).to be_nil
    end

    it 'provides a page title with the title_is assertion' do
      expect(watir_definition).to respond_to :asserted_title
      expect(watir_definition.asserted_title).to eq('Symbiote')
    end

    it 'does not verify a title if the title_is assertion has not been set' do
      expect { empty_definition.has_correct_title? }.to raise_error Symbiont::Errors::NoTitleForDefinition
    end
  end

  context 'an instance of a page definition' do
    it 'uses a perform method to reference the page' do
      expect(watir_browser).to receive(:goto).and_return('http://localhost:9292')
      watir_definition.perform
    end

    it 'verifies a page' do
      expect(watir_browser).to receive(:title).and_return('Symbiote')
      expect(watir_browser).to receive(:url).and_return('http://localhost:9292')
      watir_definition.verified?
    end

    it 'checks if a page is displayed' do
      expect(watir_browser).to receive(:url).and_return('http://localhost:9292')
      watir_definition.displayed?
    end

    it 'verifies a secure page' do
      expect(watir_browser).to receive(:url).and_return('https://localhost:9292')
      expect(watir_definition.secure?).to be_truthy
    end

    it 'gets the active url' do
      expect(watir_browser).to receive(:url).exactly(3).times.and_return('http://localhost:9292')
      expect(watir_definition).to respond_to :url
      expect(watir_definition.current_url).to eq('http://localhost:9292')
      expect(watir_definition.page_url).to eq('http://localhost:9292')
      expect(watir_definition.url).to eq('http://localhost:9292')
    end

    it 'gets the markup of a page' do
      expect(watir_browser).to receive(:html).exactly(3).times.and_return('<h1>Page Section</h1>')
      expect(watir_definition.markup).to eq('<h1>Page Section</h1>')
      expect(watir_definition.html).to eq('<h1>Page Section</h1>')
      expect(watir_definition.html).to include('<h1>Page')
    end

    it 'gets the text of a page' do
      expect(watir_browser).to receive(:text).exactly(3).times.and_return('some page text')
      expect(watir_definition.page_text).to eq('some page text')
      expect(watir_definition.text).to eq('some page text')
      expect(watir_definition.text).to include('page text')
    end

    it 'gets the title of a page' do
      expect(watir_browser).to receive(:title).exactly(3).times.and_return('Page Title')
      expect(watir_definition.page_title).to eq('Page Title')
      expect(watir_definition.title).to eq('Page Title')
      expect(watir_definition.title).to include('Title')
    end

    it 'navigates to a specific url' do
      expect(watir_browser).to receive(:goto).exactly(3).times.with('http://localhost:9292')
      watir_definition.visit('http://localhost:9292')
      watir_definition.navigate_to('http://localhost:9292')
      watir_definition.goto('http://localhost:9292')
    end

    it 'gets a screenshot of the current page' do
      expect(watir_browser).to receive(:wd).twice.and_return(watir_browser)
      expect(watir_browser).to receive(:save_screenshot).twice
      watir_definition.screenshot('testing.png')
      watir_definition.save_screenshot('testing.png')
    end

    it 'runs a script against the browser' do
      expect(watir_browser).to receive(:execute_script).twice.and_return('input')
      expect(watir_definition.run_script('return document.activeElement')).to eq('input')
      expect(watir_definition.execute_script('return document.activeElement')).to eq('input')
    end

    it 'runs a script, with arguments, against the browser' do
      expect(watir_browser).to receive(:execute_script).with('return arguments[0].innerHTML', watir_element).and_return('testing')
      expect(watir_definition.execute_script('return arguments[0].innerHTML', watir_element)).to eq('testing')
    end

    it 'gets a cookie value' do
      cookie = [{:name => 'test', :value => 'cookie', :path => '/'}]
      expect(watir_browser).to receive(:cookies).and_return(cookie)
      expect(watir_definition.get_cookie('test')).to eq('cookie')
    end

    it 'returns nothing if a cookie value is not found' do
      cookie = [{:name => 'test', :value =>'cookie', :path => '/'}]
      expect(watir_browser).to receive(:cookies).and_return(nil)
      expect(watir_definition.get_cookie('testing')).to be_nil
    end

    it 'clears all cookies from the browser' do
      expect(watir_browser).to receive(:cookies).twice.and_return(watir_browser)
      expect(watir_browser).to receive(:clear).twice
      watir_definition.remove_cookies
      watir_definition.clear_cookies
    end

    it 'refreshes the page' do
      expect(watir_browser).to receive(:refresh).twice.and_return(watir_browser)
      watir_definition.refresh_page
      watir_definition.refresh
    end

    it 'handles JavaScript alert dialogs' do
      expect(watir_browser).to receive(:alert).exactly(3).times.and_return(watir_browser)
      expect(watir_browser).to receive(:exists?).and_return(true)
      expect(watir_browser).to receive(:text)
      expect(watir_browser).to receive(:ok)
      watir_definition.will_alert {}
    end

    it 'handles JavaScript confirmation dialogs' do
      expect(watir_browser).to receive(:alert).exactly(3).times.and_return(watir_browser)
      expect(watir_browser).to receive(:exists?).and_return(true)
      expect(watir_browser).to receive(:text)
      expect(watir_browser).to receive(:ok)
      watir_definition.will_confirm(true) {}
    end

    it 'handles JavaScript prompt dialogs' do
      expect(watir_browser).to receive(:wd).twice.and_return(watir_browser)
      expect(watir_browser).to receive(:execute_script).twice
      watir_definition.will_prompt('Testing') {}
    end

    it 'attaches to a window by using the title' do
      allow(watir_browser).to receive(:window).with(:title => /Display\ Results/).and_return(watir_browser)
      allow(watir_browser).to receive(:use)
      watir_definition.within_window(title: 'Display Results')
    end

    it 'attaches to a window by using the url' do
      allow(watir_browser).to receive(:window).with(:url => /results\.html/).and_return(watir_browser)
      allow(watir_browser).to receive(:use)
      watir_definition.within_window(url: 'results.html')
    end

    it 'converts a modal popup to a window' do
      allow(watir_browser).to receive(:execute_script)
      watir_definition.within_modal {}
    end
  end
end
