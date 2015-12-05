#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rdoc/task'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new

namespace :scripts do
  desc 'Run the Symbiont Watir script.'
  task :watir do
    system('ruby ./test/symbiont-with-watir.rb')
  end

  desc 'Run the Symbiont Capybara script.'
  task :capybara do
    system('ruby ./test/symbiont-with-capybara.rb')
  end

  desc 'Run all Symbiont scripts'
  task all: [:watir, :capybara] do
  end
end

namespace :spec do
  desc 'Clean all generated reports'
  task :clean do
    system('rm -rf spec/reports')
  end

  RSpec::Core::RakeTask.new(all: :clean) do |config|
    options  = %w(--color)
    options += %w(--format documentation)
    options += %w(--format html --out spec/reports/symbiont-test-report.html)

    config.rspec_opts = options
  end
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.main = 'README.md'
  rdoc.title = "Symbiont #{Symbiont::VERSION}"
  rdoc.rdoc_files.include('README*', 'lib/**/*.rb')
end

task default: ['spec:all', :rubocop]
