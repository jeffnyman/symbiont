RSpec.describe Symbiont::Factory do
  before(:each) do
    @factory = TestFactory.new
    @factory.browser = mock_browser_for_watir
  end

  it 'will raise an exception for urls not matching' do
    expect(@factory.browser).to receive(:goto)
    expect(@factory.browser).to receive(:url).and_return 'http://localhost'
    expect { @factory.on_view(ValidPage) }.to raise_error(
      Symbiont::Errors::PageURLFromFactoryNotVerified,
      'The page URL was not verified during a factory setup.')
  end

  it 'will raise an exception for titles not matching' do
    expect(@factory.browser).to receive(:goto)
    expect(@factory.browser).to receive(:url).and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).and_return 'testing'
    expect { @factory.on_view(ValidPage) }.to raise_error(
      Symbiont::Errors::PageTitleFromFactoryNotVerified,
      'The page title was not verified during a factory setup.')
  end

  it 'will create a new definition and view it, using on_view' do
    expect(@factory.browser).to receive(:goto)
    expect(@factory.browser).to receive(:url).and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).and_return 'Symbiote'
    @factory.on_view(ValidPage)
  end

  it 'will create a new definition and view it, using on_view and a block' do
    expect(@factory.browser).to receive(:goto)
    expect(@factory.browser).to receive(:url).and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).and_return 'Symbiote'
    @factory.on_view ValidPage do |page|
      expect(page).to be_instance_of ValidPage
    end
  end

  it 'will create a new definition, using on and a block with a parameter' do
    expect(@factory.browser).not_to receive(:goto)
    expect(@factory.browser).to receive(:url).and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).and_return 'Symbiote'
    @factory.on ValidPage do |page|
      expect(page).to be_instance_of ValidPage
    end
  end

  it 'will create a new definition, using on and a block without a parameter' do
    expect(@factory.browser).not_to receive(:goto)
    expect(@factory.browser).to receive(:url).and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).and_return 'Symbiote'
    @factory.on ValidPage do
      expect(@factory.page).to be_instance_of ValidPage
    end
  end

  it 'will use an existing object reference with on' do
    expect(@factory.browser).to receive(:goto)
    expect(@factory.browser).to receive(:url).twice.and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).twice.and_return 'Symbiote'
    obj1 = @factory.on_view ValidPage
    obj2 = @factory.on ValidPage
    expect(obj1).to be(obj2)
  end

  it 'will not use an existing object reference with on_new' do
    expect(@factory.browser).to receive(:goto)
    expect(@factory.browser).to receive(:url).twice.and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).twice.and_return 'Symbiote'
    obj1 = @factory.on_view ValidPage
    obj2 = @factory.on_new ValidPage
    expect(obj1).not_to be(obj2)
  end

  it 'will set a reference to be used outside the factory' do
    expect(@factory.browser).to receive(:url).and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).and_return 'Symbiote'
    page = @factory.on ValidPage
    current = @factory.instance_variable_get '@page'
    expect(current).to be(page)
  end
end
