RSpec.describe Symbiont::Page do
  it 'responds to regions' do
    expect(Symbiont::Page).to respond_to :regions
  end

  it 'creates a matching existence method for regions' do
    class PageRegion < Symbiont::Region
    end

    class PageWithRegions < Symbiont::Page
      regions :testing, PageRegion, '.testing'
    end

    page = PageWithRegions.new
    expect(page).to respond_to :has_testing?
  end

  it 'references regions from the page' do
    class SomeRegion < Symbiont::Region
    end

    class PageWithRegion < Symbiont::Page
      regions :nav, SomeRegion, '.nav'
    end

    page = PageWithRegion.new
    nav_elements = double(['.nav', '.nav'])
    allow(nav_elements).to receive(:all).and_return(['.nav', '.nav'])
    allow(page).to receive(:page).and_return(nav_elements)
    expect(page.nav.size).to eq(2)
  end
end
