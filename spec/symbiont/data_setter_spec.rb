RSpec.describe Symbiont::DataSetter do
  include_context :page
  include_context :element

  it 'will attempt to utilize data' do
    expect(watir_element).to receive(:visible?).and_return(true)
    expect(watir_element).to receive(:enabled?).and_return(true)
    allow(watir_element).to receive(:to_subtype).and_return(watir_element)
    expect(watir_browser).to receive(:text_field).with({:id => 'text_field'}).exactly(2).times.and_return(watir_element)
    watir_definition.using(:text_field => 'works')
  end

  it 'will allow methods to be chained' do
    expect('testing'.call_method_chain("reverse.capitalize")).to eq('Gnitset')
    expect('testing'.call_method_chain("start_with?", 't')).to be_truthy
  end

end
