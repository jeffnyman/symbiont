require 'spec_helper'

describe Symbiont::Page do
  include_context :page

  context 'a page definition being used - url' do
    it 'will establish no default url' do
      expect(empty_definition.url).to be_nil
    end

    it 'will establish a page url with the url_is assertion' do
      expect(watir_definition).to respond_to :url
      expect(watir_definition.url).to eq('http://localhost:9292')
    end

    it 'will not view a page if the url_is assertion has not been set' do
      expect { empty_definition.view }.to raise_error Symbiont::Errors::NoUrlForDefinition
    end
  end

  context 'a page definition being used - url match' do
    it 'will establish no default url matcher' do
      expect(empty_definition.url_match).to be_nil
    end

    it 'will establish a url matcher with the url_matches assertion' do
      expect(watir_definition).to respond_to :url_match
      expect(watir_definition.url_match).to eq(/:\d{4}/)
    end

    it 'will not verify a url if the url_matches assertion has not been set' do
      expect { empty_definition.has_correct_url? }.to raise_error Symbiont::Errors::NoUrlMatchForDefinition
    end
  end

  context 'a page definition being used - title' do
    it 'will establish no default title' do
      expect(empty_definition.page_title).to be_nil
    end

    it 'will establish a page title with the title_is assertion' do
      expect(watir_definition).to respond_to :page_title
      expect(watir_definition.page_title).to eq('Dialogic')
    end

    it 'will not verify a title if the title_is assertion has not been set' do
      expect { empty_definition.has_correct_title? }.to raise_error Symbiont::Errors::NoTitleForDefinition
    end
  end
end
