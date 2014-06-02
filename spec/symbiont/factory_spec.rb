require 'spec_helper'

describe Symbiont::Factory do
  before(:each) do
    @factory = TestFactory.new
    @factory.driver = mock_browser_for_watir
  end

  it 'will create a new definition and view it, using on_view' do
    @factory.driver.should_receive(:goto)
    @factory.on_view(ValidPage)
  end

  it 'will create a new definition and view it, using on_view and a block' do
    @factory.driver.should_receive(:goto)
    @factory.on_view ValidPage do |page|
      page.should be_instance_of ValidPage
    end
  end

  it 'will create a new definition, using on and a block with a parameter' do
    @factory.driver.should_not_receive(:goto)
    @factory.on ValidPage do |page|
      page.should be_instance_of ValidPage
    end
  end

  it 'will create a new definition, using on and a block without a parameter' do
    @factory.driver.should_not_receive(:goto)
    @factory.on ValidPage do
      @factory.page.should be_instance_of ValidPage
    end
  end

  it 'will use an existing object reference with on' do
    @factory.driver.should_receive(:goto)
    obj1 = @factory.on_view ValidPage
    obj2 = @factory.on ValidPage
    obj1.should == obj2
  end

  it 'will not use an existing object reference with on_new' do
    @factory.driver.should_receive(:goto)
    obj1 = @factory.on_view ValidPage
    obj2 = @factory.on_new ValidPage
    obj1.should_not == obj2
  end

  it 'will create a new definition, using on_set' do
    @factory.driver.should_not_receive(:goto)
    @factory.on_set ValidPage do |page|
      page.should be_instance_of ValidPage
    end
  end

  it 'will set a reference to be used outside the factory' do
    page = @factory.on ValidPage
    current = @factory.instance_variable_get '@page'
    current.should === page
  end

  it 'will use an existing object reference with on_set' do
    @factory.driver.should_receive(:goto)
    obj1 = @factory.on_view ValidPage
    obj2 = @factory.on_set ValidPage
    obj1.should == obj2
  end

  it 'will use an existing context using on after using on_set' do
    @factory.on_set ValidPage do |page|
      @obj1 = page  # obj1 is CONTEXT, ACTIVE
    end

    @factory.on ValidPageNewContext do |page|
      @obj2 = page  # obj2 is ACTIVE
    end

    @factory.on ValidPage do |page|
      @obj3 = page  # obj1 CONTEXT is still set
    end

    @obj1.should_not == @obj2
    @obj1.should == @obj3
  end

  it 'will use an existing context using on_new of a different class after using on_set' do
    @factory.on_set ValidPage do |page|
      @obj1 = page  # obj1 is CONTEXT, ACTIVE
    end

    @factory.on_new ValidPageNewContext do |page|
      @obj2 = page  # ACTIVE nil, obj1 no longer ACTIVE, but is CONTEXT
    end

    @factory.on ValidPage do |page|
      @obj3 = page  # CONTEXT is set to obj1
    end

    @obj1.should_not == @obj2
    @obj1.should == @obj3
  end

  it 'will clear existing context using on_new after using on_set' do
    @factory.on_set ValidPage do |page|
      @obj1 = page   # obj1 is CONTEXT, ACTIVE
    end

    @factory.on_new ValidPage do |page|
      @obj2 = page   # ACTIVE nil; since page is same, CONTEXT is nil
    end

    @obj1.should_not == @obj2
  end
end
