#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

namespace :test do
  desc 'Run the Symbiont script.'
  task :script do
    system('ruby ./test/symbiont-script.rb')
  end
end

namespace :spec do
  desc 'Clean all generated reports'
  task :clean do
    system('rm -rf spec/reports')
  end

  RSpec::Core::RakeTask.new(:all => :clean) do |config|
    options  = %w(--color)
    options += %w(--format documentation)
    options += %w(--format html --out spec/reports/symbiont-test-report.html)
    options += %w(--format nested --out spec/reports/symbiont-test-report.txt)

    config.rspec_opts = options
  end
end

task default: %w(spec:all)
