RSpec.describe Symbiont::Page do
  it 'responds to elements' do
    expect(Symbiont::Page).to respond_to :elements
  end

  it 'returns the collection object' do
    class PageWithElement < Symbiont::Page
      element :facts, '#list'
    end
    page = PageWithElement.new
    expect(page).to respond_to :facts
  end

  it 'provides an existence check method for a collection' do
    class PageWithElement < Symbiont::Page
      elements :facts, '#list'
    end
    page = PageWithElement.new
    expect(page).to respond_to :has_facts?
  end
end
