RSpec.describe Symbiont::Page do
  it 'responds to element' do
    expect(Symbiont::Page).to respond_to :element
  end

  it 'returns the element object' do
    class PageWithElement < Symbiont::Page
      element :search, '#search'
    end
    page = PageWithElement.new
    expect(page).to respond_to :search
  end

  it 'provides an existence check method' do
    class PageWithElement < Symbiont::Page
      element :search, '#search'
    end
    page = PageWithElement.new
    expect(page).to respond_to :has_search?
  end

  it 'provides a non-existence check method' do
    class PageWithElement < Symbiont::Page
      element :search, '#search'
    end
    page = PageWithElement.new
    expect(page).to respond_to :has_no_search?
  end

  it 'provides a wait check method' do
    class PageWithElement < Symbiont::Page
      element :slow_element, "input[id='slow']"
    end
    page = PageWithElement.new
    expect(page).to respond_to :wait_for_slow_element
  end

  it 'checks elements for presence and absence' do
    class PageWithElement < Symbiont::Page
      element :search, '#search'
    end
    page = PageWithElement.new
    search_element = double('element')
    expect(page).to receive(:has_selector?).and_return(search_element)
    expect(page.has_search?).to be_truthy

    expect(page).to receive(:has_no_selector?).and_return(nil)
    expect(page.has_no_search?).to be_falsey
  end

  it 'provides a way to interact with elements' do
    class PageWithElement < Symbiont::Page
      element :search, '#search'
    end
    page = PageWithElement.new
    search_element = double('element')
    expect(search_element).to receive(:click)
    expect(page).to receive(:find).and_return(search_element)
    page.search.click
  end

  it 'provides a way to interact with element collections' do
    class PageWithElement < Symbiont::Page
      elements :search, '#search'
    end
    page = PageWithElement.new
    search_element = double('element')
    expect(search_element).to receive(:click)
    expect(page).to receive(:all).and_return(search_element)
    page.search.click
  end

  it 'waits for an element to exist' do
    class PageWithElement < Symbiont::Page
      element :search, '#search'
    end
    page = PageWithElement.new
    page.wait_for_search(10)
  end

  it 'waits for an element to be visible' do
    class PageWithElement < Symbiont::Page
      element :search, '#search'
    end
    page = PageWithElement.new
    search_element = double('element')
    expect(page).to receive(:element_exists?).and_return(search_element)
    page.wait_until_search_visible(10)
  end

  it 'waits for an element to be invisible' do
    class PageWithElement < Symbiont::Page
      element :search, '#search'
    end
    page = PageWithElement.new
    search_element = double('element')
    expect(page).to receive(:element_exists?).and_return(nil)
    page.wait_until_search_invisible(10)
  end
end
