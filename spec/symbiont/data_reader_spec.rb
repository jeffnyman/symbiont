module TestModule
  extend Symbiont::DataReader

  def self.default_data_path
    'default_test_path'
  end
end

RSpec.describe Symbiont::DataReader do
  context 'when configuring the data directory' do
    before(:each) do
      TestModule.data_path = nil
    end

    it 'should store a data directory' do
      TestModule.data_path = 'test_path'
      expect(TestModule.data_path).to eq 'test_path'
    end

    it 'should default to a directory specified by the containing class' do
      expect(TestModule.data_path).to eq 'default_test_path'
    end
  end
end
