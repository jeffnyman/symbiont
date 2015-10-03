RSpec.describe Symbiont::DataBuilder do
  include_context :page

  context 'when configuring the data path' do
    it 'will default to a directory named data' do
      expect(Symbiont::DataBuilder.data_path).to eq('data')
    end

    it 'will store a data source directory' do
      Symbiont::DataBuilder.data_path = 'config/data'
      expect(Symbiont::DataBuilder.data_path).to eq('config/data')
    end
  end

  context 'when reading data files' do
    it 'will read files from the data path directory' do
      Symbiont::DataBuilder.data_path = 'config/data'
      expect(YAML).to receive(:load_file).with('config/data/test_data_file').and_return({})
      Symbiont::DataBuilder.load('test_data_file')
    end

    it 'will load the correct data file from the default' do
      Symbiont::DataBuilder.data_path = 'spec/fixtures'
      data = watir_definition.data_about 'valid'
      expect(data.keys.sort).to eq(['bank','name'])
    end
  end

  context 'when provided a file' do
    it 'will load the correct data file and retrieve data' do
      Symbiont::DataBuilder.data_path = 'spec/fixtures'
      data = watir_definition.data_about 'mock_data/valid'
      expect(data.keys.sort).to eq(['bank','name'])
    end
  end
end
