RSpec.describe Symbiont do
  it 'returns version information' do
    expect(Symbiont.version).to include("Symbiont v#{Symbiont::VERSION}")
  end
end
