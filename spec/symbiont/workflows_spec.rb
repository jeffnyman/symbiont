require 'spec_helper'

class TestPage01
end

class TestPage02
end

class TestPage03
end

class TestWorkflow
  include Symbiont::Workflow

  def on(caller)
    caller.new
  end
end

describe Symbiont::Workflow do
  before(:each) do
    @test_workflow = TestWorkflow.new
  end

  it 'should store the paths' do
    paths = %w(a b c)
    TestWorkflow.paths = {:default => paths}
    expect(TestWorkflow.paths[:default]).to eq paths
  end

  it 'should store path data' do
    TestWorkflow.path_data = {:default => :test}
    expect(TestWorkflow.path_data).to eq({:default => :test})
  end

  it 'should fail when it does not find a proper path' do
    TestWorkflow.paths = {:default => ['a'], :testing => ['b']}
    expect { @test_workflow.workflow_for(TestPage02, :using => :no_path )}.to raise_error
  end

  it 'should navigate to a page calling the default methods (multiple paths)' do
    pages = [[TestPage01, :a_method], [TestPage02, :b_method]]
    TestWorkflow.paths = {:default => pages}
    mock_page = double('mock_page')

    allow(TestPage01).to receive(:new).and_return(mock_page)
    allow(mock_page).to receive(:a_method)

    expect(@test_workflow.workflow_for(TestPage02).class).to eq TestPage02
  end

  it 'should navigate to a page calling the default methods (only one path)' do
    pages = [[TestPage01, :a_method]]
    TestWorkflow.paths = {:default => pages}
    mock_page = double('mock_page')

    allow(TestPage01).to receive(:new).and_return(mock_page)
    allow(mock_page).to receive(:a_method)

    expect(@test_workflow.workflow_for(TestPage01).class).to eq RSpec::Mocks::Double
  end

  it 'should load the DataBuilder file when specified' do
    pages = [[TestPage01, :a_method], [TestPage02, :b_method]]
    TestWorkflow.paths = {:default => pages}
    TestWorkflow.path_data = {:default => :test}
    mock_page = double('mock_page')

    allow(TestPage01).to receive(:new).and_return(mock_page)
    allow(mock_page).to receive(:a_method)
    allow(Symbiont::DataBuilder).to receive(:load).with('test.yml')

    expect(@test_workflow.workflow_for(TestPage02).class).to eq TestPage02
  end

  it 'should pass parameters to methods when navigating' do
    pages = [[TestPage01, :a_method, 'test'], [TestPage02, :b_method]]
    TestWorkflow.paths = {:default => pages}
    mock_page = double('mock_page')

    allow(TestPage01).to receive(:new).and_return(mock_page)
    allow(mock_page).to receive(:a_method).with('test')

    expect(@test_workflow.workflow_for(TestPage02).class).to eq TestPage02
  end

  it 'should fail when no default method is specified' do
    TestWorkflow.paths = {
        :default => [[TestPage01, :a_method], [TestPage02, :b_method]]
    }
    mock_page = double('mock_page')
    allow(TestPage01).to receive(:new).and_return(mock_page)
    allow(mock_page).to receive(:respond_to?).with(:a_method).and_return(false)
    expect { @test_workflow.workflow_for(TestPage02) }.to raise_error
  end
end