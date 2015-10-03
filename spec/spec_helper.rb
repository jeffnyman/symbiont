$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  coverage_dir "#{SimpleCov.root}/spec/reports/coverage"
  minimum_coverage 90
  maximum_coverage_drop 5
end

require 'symbiont'


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.disable_monkey_patching!

  config.warnings = false

  config.default_formatter = 'doc' if config.files_to_run.one?

  # config.order = :random
  # config.profile_examples = 10
  # Kernel.srand config.seed
end

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

  config.alias_it_should_behave_like_to :provides_an, 'when providing an'

  RSpec.shared_context :page do
    let(:watir_browser)        { mock_browser_for_watir }
    let(:watir_definition)     { ValidPage.new(watir_browser) }

    let(:empty_definition)     { PageWithMissingAssertions.new(watir_browser) }
    let(:no_driver_definition) { ValidPage.new(:unknown) }
  end

  RSpec.shared_context :element do
    let(:watir_element) { double('element') }
  end
end

Dir['spec/fixtures/**/*.rb'].each do |file|
  require file.sub(/spec\//, '')
end
