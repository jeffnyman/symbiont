require 'spec_helper'

describe Symbiont::Page do
  context 'a page definition being used - url' do
    it 'will establish no default url' do
      page = PageWithMissingAssertions.new
      expect(PageWithMissingAssertions.url).to be_nil
      expect(page.url).to be_nil
    end

    it 'will establish a page url with the url_is assertion' do
      page = ValidPage.new
      expect(page).to respond_to :url
      expect(page.url).to eq('http://localhost:9292')
    end

    it 'will not view a page if the url_is assertion has not been set' do
      page = PageWithMissingAssertions.new
      expect { page.view }.to raise_error Symbiont::Errors::NoUrlForDefinition
    end

    it 'will view a page if the url_is assertion has been set' do
      page = ValidPage.new
      expect { page.view }.not_to raise_error
    end
  end

  context 'a page definition being used - url match' do
    it 'will establish no default url matcher' do
      page = PageWithMissingAssertions.new
      expect(PageWithMissingAssertions.url_match).to be_nil
      expect(page.url_match).to be_nil
    end

    it 'will establish a url matcher with the url_matches assertion' do
      page = ValidPage.new
      expect(ValidPage).to respond_to :url_match
      expect(page.url_match).to eq(/:\d{4}/)
    end

    it 'will not verify a url if the url_matches assertion has not been set' do
      page = PageWithMissingAssertions.new
      expect { page.has_correct_url? }.to raise_error Symbiont::Errors::NoUrlMatchForDefinition
    end
  end

  context 'a page definition being used - title' do
    it 'will establish no default title' do
      page = PageWithMissingAssertions.new
      expect(PageWithMissingAssertions.title).to be_nil
      expect(page.title).to be_nil
    end

    it 'will establish a page title with the title_is assertion' do
      page = ValidPage.new
      expect(ValidPage).to respond_to :title
      expect(page.title).to eq('Dialogic')
    end

    it 'will not verify a title if the title_is assertion has not been set' do
      page = PageWithMissingAssertions.new
      expect { page.has_correct_title? }.to raise_error Symbiont::Errors::NoTitleForDefinition
    end

    it 'will verify a title if the title_is assertion has been set' do
      page = ValidPage.new
      expect { page.has_correct_title? }.not_to raise_error
    end
  end
end
