require 'simplecov'

SimpleCov.start do
  add_filter '/spec'
  coverage_dir "#{SimpleCov.root}/spec/reports/coverage"
  minimum_coverage 90
  maximum_coverage_drop 5
end

require 'symbiont'

RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    $stderr = File.new(File.join(File.dirname(__FILE__), 'reports/symbiont-output.txt'), 'w')
    $stdout = File.new(File.join(File.dirname(__FILE__), 'reports/symbiont-output.txt'), 'w')
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end

  shared_context :page do
    let(:watir_browser)    { mock_browser_for_watir }
    let(:watir_definition) { ValidPage.new(watir_browser) }
    let(:empty_definition) { PageWithMissingAssertions.new(watir_browser) }
  end
end

Dir['spec/fixtures/**/*.rb'].each do |file|
  require file.sub(/spec\//, '')
end
