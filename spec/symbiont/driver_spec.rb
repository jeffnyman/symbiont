require 'spec_helper'

describe 'Page Definitions' do
  include_context :page

  context 'a definition using watir-webdriver' do
    context 'with a url_is assertion' do
      it 'will call the driver navigation method when viewed' do
        watir_browser.should_receive(:goto).twice
        expect { watir_definition.view }.not_to raise_error
        watir_definition.view
      end
    end

    context 'with a url_matches assertion' do
      it 'will verify a url if the url_matches assertion has been set' do
        watir_browser.should_receive(:url).twice.and_return('http://localhost:9292')
        expect { watir_definition.has_correct_url? }.not_to raise_error
        watir_definition.has_correct_url?.should be_true
      end

      it 'will not verify a url if the url does not match the url_matches assertion' do
        watir_browser.should_receive(:url).and_return('http://127.0.0.1')
        watir_definition.has_correct_url?.should be_false
      end
    end

    context 'with a title_is assertion' do
      it 'will verify a title if the title_is assertion has been set' do
        watir_browser.should_receive(:title).twice.and_return 'Dialogic'
        expect { watir_definition.has_correct_title? }.not_to raise_error
        watir_definition.has_correct_title?.should be_true
      end

      it 'will not verify a title if the title does not match the title_is assertion' do
        watir_browser.should_receive(:title).and_return('Page Title')
        watir_definition.has_correct_title?.should be_false
      end
    end
  end

  context 'a definition using selenium-webdriver' do
    context 'with a url_is assertion' do
      it 'will call the driver navigation method when viewed' do
        selenium_browser.stub_chain(:navigate, :to).twice
        expect { selenium_definition.view }.not_to raise_error
        selenium_definition.view
      end
    end

    context 'with a url_matches assertion' do
      it 'will verify a url if the url_matches assertion has been set' do
        selenium_browser.should_receive(:current_url).twice.and_return('http://localhost:9292')
        expect { selenium_definition.has_correct_url? }.not_to raise_error
        selenium_definition.has_correct_url?.should be_true
      end
    end

    context 'with a title_is assertion' do
      it 'will verify a title if the title_is assertion has been set' do
        selenium_browser.should_receive(:title).twice.and_return 'Dialogic'
        expect { selenium_definition.has_correct_title? }.not_to raise_error
        selenium_definition.has_correct_title?.should be_true
      end
    end
  end

  context 'a definition using an unrecognized driver' do
    it 'will not be able to establish a platform with the driver' do
      expect { no_driver_definition }.to raise_error Symbiont::Errors::UnableToCreatePlatform
    end
  end
end
