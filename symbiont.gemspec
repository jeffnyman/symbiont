# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'symbiont/version'

Gem::Specification.new do |spec|
  spec.name          = 'symbiont'
  spec.version       = Symbiont::VERSION
  spec.authors       = ['Jeff Nyman']
  spec.email         = ['jeffnyman@gmail.com']
  spec.summary       = %q{An Endosymbiotic Facultative Semantically Clean Fluent Interface Test Framework}
  spec.description   = %q{
    Symbiont is a framework that allows you to describe your application in
    terms of activity and page definitions. Those definitions can then be
    referenced by test libraries using the DSL that Symbiont provides. The
    DSL allows web elements to be proxied to a driver library.

    The DSL provides a fluent interface that can be used for constructing
    test execution logic. This fluent interface promotes the idea of
    compressibility of your test logic, allowing for more factoring, more
    reuse, and less repetition.

    You can use Symbiont directly as an automated test library or you can
    use it with other tools such as RSpec, Cucumber, or my own Specify tool.
  }
  spec.homepage      = 'https://github.com/jnyman/symbiont'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.requirements  << 'Watir-WebDriver, Capybara, Savon'

  spec.required_ruby_version     = '>= 2.0'
  spec.required_rubygems_version = '>= 1.8.29'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubocop'

  spec.add_runtime_dependency 'colorize'
  spec.add_runtime_dependency 'watir-webdriver'
  spec.add_runtime_dependency 'watir-dom-wait'
  spec.add_runtime_dependency 'watir-scroll'
  spec.add_runtime_dependency 'savon'
  spec.add_runtime_dependency 'capybara', ['>= 2.1', '< 3.0']

  spec.post_install_message = %{
(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

  Symbiont #{Symbiont::VERSION} has been installed.

(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)
  }
end
