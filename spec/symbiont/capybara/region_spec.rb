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

      it 'creates a matching existence method for a region' do
        class PageRegion < Symbiont::Region
        end

        class AnotherPageWithRegion < Symbiont::Page
          region :testing, PageRegion, '.testing'
        end

        page = AnotherPageWithRegion.new
        expect(page).to respond_to :has_testing?
      end
    end

    context 'second argument is not a class and a block is given' do
      it 'should create an anonymous section with the block' do
        class PageWithRegion < Symbiont::Page
          region :testing, '.testing' do |item|
            item.element :title, 'h1'
          end
        end

        page = PageWithRegion.new
        expect(page).to respond_to :testing
      end
    end

    context 'second argument is not a class and no block is given' do
      it 'should raise an ArgumentError' do
        class Page < Symbiont::Page
        end
        expect { Page.region :testing, '.testing' }.to raise_error ArgumentError, 'Provide a region class either as a block or as the second argument.'
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
