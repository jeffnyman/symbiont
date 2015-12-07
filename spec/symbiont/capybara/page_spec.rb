RSpec.describe Symbiont::Page do
  it 'responds to view' do
    expect(Symbiont::Page.new).to respond_to :view
  end

  it 'responds to url_is' do
    expect(Symbiont::Page).to respond_to :url_is
  end

  it 'allows a url to be set' do
    class SamplePageWithUrl < Symbiont::Page
      url_is '/test_page'
    end
    page = SamplePageWithUrl.new
    expect(page.url).to eq('/test_page')
  end

  it 'provides no urls as defaults' do
    class SamplePageNoUrl < Symbiont::Page; end
    page = SamplePageNoUrl.new
    expect(SamplePageNoUrl.url).to be_nil
    expect(page.url).to be_nil
  end

  it 'allows viewing of the page if the url has been set' do
    class SamplePageWithUrl < Symbiont::Page
      url_is '/test_page'
    end
    page_with_url = SamplePageWithUrl.new
    expect { page_with_url.view }.to_not raise_error
  end

  it 'does not allow loading if the url is not set' do
    class SamplePageNoUrl < Symbiont::Page; end
    page_with_no_url = SamplePageNoUrl.new
    expect { page_with_no_url.view }.to raise_error(Symbiont::Errors::NoUrlForDefinition)
  end

  it 'responds to url_matches' do
    expect(Symbiont::Page).to respond_to :url_matches
  end

  it 'allows a url matcher to be set' do
    class SamplePageWithUrlMatcher < Symbiont::Page
      url_matches /stardate/
    end
    page = SamplePageWithUrlMatcher.new
    expect(page.url_matcher).to eq(/stardate/)
  end

  it 'provides no url matchers as defaults' do
    class SamplePageNoUrlMatcher < Symbiont::Page; end
    page = SamplePageNoUrlMatcher.new
    expect(SamplePageNoUrlMatcher.url_matcher).to be_nil
    expect(page.url_matcher).to be_nil
  end

  it 'allows checking the page url with a url matcher present' do
    class SamplePageWithUrlMatcher < Symbiont::Page
      url_matches /stardate/
    end
    page = SamplePageWithUrlMatcher.new
    expect { page.displayed? }.to_not raise_error
  end

  it 'does not check the page url if a url matcher is not present' do
    class SamplePageWithNoUrlMatcher < Symbiont::Page; end
    expect { SamplePageWithNoUrlMatcher.new.displayed? }.to raise_error Symbiont::Errors::NoUrlMatchForDefinition
  end

  it 'determine if a url is secure' do
    expect(Symbiont::Page.new).to respond_to :secure?
    class SamplePageWithUrl < Symbiont::Page
      url_is '/test_page'
    end
    page_with_url = SamplePageWithUrl.new
    expect(page_with_url.secure?).to be_falsey
  end

  it 'exposes the page title' do
    expect(Symbiont::Page.new).to respond_to :title
  end

  it 'exposes the current url of the page' do
    expect(Symbiont::Page.new).to respond_to :current_url
  end

  it 'allows chainable navigation and action' do
    page = Symbiont::Page.new
    expect(page).to receive(:view)
    page.perform
  end

  it 'allows markup content to be loaded' do
    page = Symbiont::Page.new
    expect { page.view('<html></html>') }.not_to raise_error
  end

  describe 'ready?' do
    it 'is true if displayed' do
      page = Symbiont::Page.new
      allow(page).to receive(:displayed?).and_return true
      expect(page).to be_ready
    end

    it 'is false if not displayed' do
      page = Symbiont::Page.new
      allow(page).to receive(:displayed?).and_return false
      expect(page).not_to be_ready
    end
  end

  context 'when passed a block' do
    let(:page_with_ready_validations) do
      Class.new(Symbiont::Page) do
        url_is '/test_page'

        def is_true
          true
        end

        def also_true
          true
        end

        def test?
          true
        end

        page_ready_when { [is_true, 'Was not true but should have been.'] }
        page_ready_when { [also_true, 'Was not true but should have been.'] }
      end
    end

    it 'executes the block actions when ready validations pass' do
      page = page_with_ready_validations.new
      expect { page.view { true } }.not_to raise_error
    end

    it 'yields itself to the passed block' do
      page = page_with_ready_validations.new
      expect(page).to receive(:test?)
      page.view { |p| p.test? && true }
    end

    it 'raises an error when a block passed and ready validations fail' do
      page = page_with_ready_validations.new
      expect(page).to receive(:is_true).and_return(false)
      expect { page.view { puts 'testing' } }.to raise_error(Symbiont::Errors::PageNotValidatedError, /Was not true/)
    end
  end
end
