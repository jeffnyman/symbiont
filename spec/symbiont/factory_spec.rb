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

  it 'will raise an exception for urls not matching' do
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
    expect(@factory.browser).to receive(:url).and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).and_return 'Symbiote'
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

  it 'will create a new definition, using on_set' do
    expect(@factory.browser).not_to receive(:goto)
    expect(@factory.browser).to receive(:url).and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).and_return 'Symbiote'
    @factory.on_set ValidPage do |page|
      expect(page).to be_instance_of ValidPage
    end
  end

  it 'will set a reference to be used outside the factory' do
    expect(@factory.browser).to receive(:url).and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).and_return 'Symbiote'
    page = @factory.on ValidPage
    current = @factory.instance_variable_get '@page'
    expect(current).to be(page)

    current = @factory.instance_variable_get '@model'
    expect(current).to be(page)
  end

  it 'will use an existing object reference with on_set' do
    expect(@factory.browser).to receive(:url).and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).and_return 'Symbiote'
    expect(@factory.browser).to receive(:goto)
    obj1 = @factory.on_view ValidPage
    obj2 = @factory.on_set ValidPage
    expect(obj1).to be(obj2)
  end

  it 'will use an existing context using on after using on_set' do
    expect(@factory.browser).to receive(:url).twice.and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).twice.and_return 'Symbiote'
    @factory.on_set ValidPage do |page|
      @obj1 = page  # obj1 is CONTEXT, ACTIVE
    end

    @factory.on ValidPageNewContext do |page|
      @obj2 = page  # obj2 is ACTIVE
    end

    @factory.on ValidPage do |page|
      @obj3 = page  # obj1 CONTEXT is still set
    end

    expect(@obj1).not_to be(@obj2)
    expect(@obj1).to be(@obj3)
  end

  it 'will use an existing context using on_new of a different class after using on_set' do
    expect(@factory.browser).to receive(:url).twice.and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).twice.and_return 'Symbiote'
    @factory.on_set ValidPage do |page|
      @obj1 = page  # obj1 is CONTEXT, ACTIVE
    end

    @factory.on_new ValidPageNewContext do |page|
      @obj2 = page  # ACTIVE nil, obj1 no longer ACTIVE, but is CONTEXT
    end

    @factory.on ValidPage do |page|
      @obj3 = page  # CONTEXT is set to obj1
    end

    expect(@obj1).not_to be(@obj2)
    expect(@obj1).to be (@obj3)
  end

  it 'will clear existing context using on_new after using on_set' do
    expect(@factory.browser).to receive(:url).twice.and_return 'http://localhost:9292'
    expect(@factory.browser).to receive(:title).twice.and_return 'Symbiote'
    @factory.on_set ValidPage do |page|
      @obj1 = page   # obj1 is CONTEXT, ACTIVE
    end

    @factory.on_new ValidPage do |page|
      @obj2 = page   # ACTIVE nil; since page is same, CONTEXT is nil
    end

    expect(@obj1).not_to be(@obj2)
  end
end
