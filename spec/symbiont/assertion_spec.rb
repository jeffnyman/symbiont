RSpec.describe Symbiont::Assertion do
  context 'a definition with valid assertions' do
    it 'allows a url to be asserted' do
      expect {
        class PageWithUrl
          attach Symbiont
          url_is 'http://localhost:9292'
        end
      }.not_to raise_error
    end

    it 'allows a url match pattern to be asserted' do
      expect {
        class PageWithUrlMatches
          attach Symbiont
          url_matches /localhost/
        end
      }.not_to raise_error
    end

    it 'allows a title to be asserted' do
      expect {
        class PageWithTitle
          attach Symbiont
          title_is 'Dialogic'
        end
      }.not_to raise_error
    end
  end

  context 'a definition with missing assertion values' do
    it 'indicates a missing url_is assertion value' do
      expect {
        class PageWithMissingUrl
          attach Symbiont
          url_is
        end
      }.to raise_error Symbiont::Errors::NoUrlForDefinition
    end

    it 'indicates an empty url_is assertion value' do
      expect {
        class PageWithEmptyUrl
          attach Symbiont
          url_is ''
        end
      }.to raise_error Symbiont::Errors::NoUrlForDefinition
    end

    it 'indicates a missing url_matches assertion value' do
      expect {
        class PageWithMissingUrlMatch
          attach Symbiont
          url_matches
        end
      }.to raise_error Symbiont::Errors::NoUrlMatchForDefinition
    end

    it 'indicates an empty url_matches assertion value' do
      expect {
        class PageWithEmptyUrlMatch
          attach Symbiont
          url_matches ''
        end
      }.to raise_error Symbiont::Errors::NoUrlMatchForDefinition
    end

    it 'indicates a missing title_is assertion value' do
      expect {
        class PageWithMissingTitle
          attach Symbiont
          title_is
        end
      }.to raise_error Symbiont::Errors::NoTitleForDefinition
    end

    it 'indicates an empty title_is assertion value' do
      expect {
        class PageWithEmptyTitle
          attach Symbiont
          title_is ''
        end
      }.to raise_error Symbiont::Errors::NoTitleForDefinition
    end
  end
end
