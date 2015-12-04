RSpec.describe Symbiont do
  it 'disables implicit waits by default' do
    expect(Symbiont.use_implicit_waits).to be false
  end

  it 'uses implicit waits by configuration' do
    Symbiont.configure do |config|
      config.use_implicit_waits = true
    end
    expect(Symbiont.use_implicit_waits).to be true
  end
end
