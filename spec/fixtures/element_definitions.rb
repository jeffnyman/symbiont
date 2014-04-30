shared_examples_for 'element generator for' do |elements|
  elements.each do |element|

    context "#{element} on the watir-webdriver platform" do
      it "will locate a specific #{element} with a single locator" do
        expect(watir_browser).to receive(element).with(id: element).and_return(watir_element)
        expect(watir_definition.send "#{element}").to eq(watir_element)
      end

      it "will locate a specific #{element} with a proc" do
        expect(watir_browser).to receive(element).with(id: element).and_return(watir_element)
        expect(watir_definition.send "#{element}_proc").to eq(watir_element)
      end

      it "will locate a specific #{element} with a lambda" do
        expect(watir_browser).to receive(element).with(id: element).and_return(watir_element)
        expect(watir_definition.send "#{element}_lambda").to eq(watir_element)
      end

      it "will locate a specific #{element} with a block" do
        expect(watir_browser).to receive(element).with(id: element).and_return(watir_element)
        expect(watir_definition.send "#{element}_block", element).to eq(watir_element)
      end

      it "will locate a specific #{element} with a block and argument" do
        expect(watir_browser).to receive(element).with(id: element).and_return(watir_element)
        expect(watir_definition.send "#{element}_block_arg", element).to eq(watir_element)
      end
    end

  end
end
