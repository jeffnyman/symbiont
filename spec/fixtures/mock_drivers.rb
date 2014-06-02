require 'watir-webdriver'

def mock_browser_for_watir
  watir_browser = double('watir')
  allow(watir_browser).to receive(:is_a?).with(Watir::Browser).and_return(true)
  allow(watir_browser).to receive(:is_a?).with(Selenium::WebDriver::Driver).and_return(false)
  watir_browser
end
