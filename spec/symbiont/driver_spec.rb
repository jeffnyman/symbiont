RSpec.describe 'Symbiont Driver' do
  include_context :page

  context 'a symbiont driver is requested' do
    it 'will provide the default browser' do
      allow(Watir::Browser).to receive(:new).and_return(Symbiont.browser)
      Symbiont.set_browser
    end
  end
end

RSpec.describe 'Page Definitions' do
  include_context :page

  context 'a definition using watir-webdriver' do
    context 'with a url_is assertion' do
      it 'will call the driver navigation method when viewed' do
        expect(watir_browser).to receive(:goto).twice
        expect { watir_definition.view }.not_to raise_error
        watir_definition.view
      end
    end

    context 'with a url_matches assertion' do
      it 'will verify a url if the url_matches assertion has been set' do
        expect(watir_browser).to receive(:url).twice.and_return('http://localhost:9292')
        expect { watir_definition.correct_url? }.not_to raise_error
        expect(watir_definition.correct_url?).to be_truthy
      end

      it 'will not verify a url if the url does not match the url_matches assertion' do
        expect(watir_browser).to receive(:url).and_return('http://127.0.0.1')
        expect(watir_definition.correct_url?).to be_falsey
      end
    end

    context 'with a title_is assertion' do
      it 'will verify a title if the title_is assertion has been set' do
        expect(watir_browser).to receive(:title).twice.and_return 'Dialogic'
        expect { watir_definition.correct_title? }.not_to raise_error
        expect(watir_definition.correct_title?).to be_truthy
      end

      it 'will not verify a title if the title does not match the title_is assertion' do
        expect(watir_browser).to receive(:title).and_return('Page Title')
        expect(watir_definition.correct_title?).to be_falsey
      end
    end
  end
end
