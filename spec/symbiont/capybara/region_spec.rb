RSpec.describe Symbiont::Page do
  it 'responds to region' do
    expect(Symbiont::Page).to respond_to :region
  end

  describe 'regions' do
    context 'provided as a class' do
      it 'creates a method' do
        class SomeRegion < Symbiont::Region
        end

        class PageWithRegion < Symbiont::Page
          region :nav, SomeRegion, '.nav'
        end

        page = PageWithRegion.new
        expect(page).to respond_to :nav
      end

      it 'references a region from the page' do
        class SomeRegion < Symbiont::Region
          element :open, '#open'
        end

        class PageWithRegion < Symbiont::Page
          region :nav, SomeRegion, '#nav'
        end

        page = PageWithRegion.new
        nav_element = double('#nav')
        open_element = double('#open')
        expect(page).to receive(:find).and_return(nav_element)
        allow(page).to receive(:page).and_return(open_element)
        expect { page.nav }.not_to raise_error
      end

      it 'references a region element from the page' do
        class SomeRegion < Symbiont::Region
          element :open, '#open'
        end

        class PageWithRegion < Symbiont::Page
          region :nav, SomeRegion, '#nav'
        end

        page = PageWithRegion.new
        nav_element = double('#nav')
        open_element = double('#open')

        expect(open_element).to receive(:find).and_return(open_element)
        expect(nav_element).to receive(:find).and_return(open_element)
        allow(page).to receive(:page).and_return(nav_element)
        expect { page.nav.open }.not_to raise_error
      end
    end
  end
end

RSpec.describe Symbiont::Region do
  it 'responds to element' do
    expect(Symbiont::Region).to respond_to :element
  end

  it 'responds to elements' do
    expect(Symbiont::Region).to respond_to :elements
  end
end
