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
    use it with other tools such as RSpec, Cucumber, or my own Lucid tool.
  }
  spec.homepage      = 'https://github.com/jnyman/symbiont'
  spec.license       = 'MIT'
  spec.requirements  << 'Watir-WebDriver, Colorize'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|specs|features)/})
  spec.require_paths = %w(lib)

  spec.required_ruby_version     = '>= 1.9.3'
  spec.required_rubygems_version = '>= 1.8.29'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_runtime_dependency 'colorize', '~> 0.7'
  spec.add_runtime_dependency 'watir-webdriver', '~> 0.6'

  spec.post_install_message = %{
(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

  Symbiont #{Symbiont::VERSION} has been installed.

(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)
  }
end
