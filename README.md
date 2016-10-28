# Symbiont

[![Gem Version](https://badge.fury.io/rb/symbiont.svg)](http://badge.fury.io/rb/symbiont)
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/jnyman/symbiont/blob/master/LICENSE.txt)

[![Build Status](https://travis-ci.org/jnyman/symbiont.svg)](https://travis-ci.org/jnyman/symbiont)
[![Dependency Status](https://gemnasium.com/jnyman/symbiont.png)](https://gemnasium.com/jnyman/symbiont)
[![Code Climate](https://codeclimate.com/github/jnyman/symbiont/badges/gpa.svg)](https://codeclimate.com/github/jnyman/symbiont)
[![Gitter chat](https://badges.gitter.im/jnyman/symbiont.png)](https://gitter.im/jnyman/symbiont)
 
Symbiont provides a semantic domain-specific language that can be used to construct a fluent interface for test execution libraries. The initial focus will be on using the [watir-webdriver](https://github.com/watir/watir-webdriver) API as the underlying driver library.

## What is this?

Symbiont is a test solution micro-framework.

A micro-framework provides a focused solution, which means it does one thing and one thing only, instead of trying to solve each and every problem. While doing that one thing it does well, the micro-framework should do it while being expressive yet concise. Further, it should be able to serve as one component of your own custom modularized framework, allowing you to compose solutions. To that end, you can use Symbiont directly as an automated test library or you can use it with other tools such as [RSpec](http://rspec.info/), [Cucumber](http://cukes.info/), or my own [Specify](https://github.com/jeffnyman/specify) tool.

In terms of what Symbiont does, it provides a way to describe your application in terms of activity and page definitions. Those definitions can then be referenced as part of the DSL that Symbiont provides. This DSL can be utilized in the context of the [Watir-WebDriver test library](https://github.com/watir/watir-webdriver).

The DSL provides a fluent interface that can be used for constructing test execution logic. This fluent interface promotes the idea of compressibility of your test logic, allowing for more factoring, more reuse, and less repetition.

## Installation

To get the latest stable release, add this line to your application's Gemfile:

    gem 'symbiont'

To get the latest code:

```ruby
gem 'symbiont', git: https://github.com/jnyman/symbiont
```

After doing one of the above, execute the following command:

    $ bundle

You can also install Symbiont just as you would any other gem:

    $ gem install symbiont

## Usage

To learn how to use the framework, you can check out my [blog posts on Symbiont](http://testerstories.com/category/symbiont/) and for the most up to date information, you can check out the [Symbiont Wiki](https://github.com/jnyman/symbiont/wiki).

You can check out the [Symbiont Watir test script](https://github.com/jnyman/symbiont/blob/master/test/symbiont-with-watir.rb) or the [Symbiont Capybara test script](https://github.com/jnyman/symbiont/blob/master/test/symbiont-with-capybara.rb) for an idea of how the library can be interacted with. Do note that the test scripts will use my [Decohere](http://decohere.herokuapp.com/) web application. To execute the test scripts, do one of the following:

    $ rake scripts:watir
    $ rake scripts:capybara

## Why call it Symbiont?

If you are a comic book reader, particularly in the Marvel Universe, you will know of the [Klyntar](http://marvel.wikia.com/Klyntar), a race of symbiotic creatures. While those creatures have been a mixed bag in terms of good and evil, they are symbionts, which are organisms that exist in a partnership with something else. The terms comes from the Greek _symbiōtēs_ ("companion"), from an earlier term _symbioun_ ("to live together").

A "symbiont" is an organism in a symbiotic (mutually beneficial) relationship. Some of these relationships are called _obligate_, which means that both organisms need each other in order to survive. Other such relationships are called _facultative_, meaning that both organisms don't strictly need each other to survive, but they stand a better chance if they do.

Symbiotic relationships include associations in which one organism lives on another organism -- _ectosymbiosis_ -- or where one organism lives inside the other -- _endosymbiosis_.

So, with that bit of context, think of this library as a facultative, endosymbiotic organism that lives within your test logic, giving it strength and sustenance.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/jnyman/symbiont](https://github.com/jnyman/symbiont). The testing ecosystem of Ruby is very large and this project is intended to be a welcoming arena for collaboration on yet another testing tool. As such, contributors are very much welcome but are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

To contribute to Symbiont:

1. [Fork the project](http://gun.io/blog/how-to-github-fork-branch-and-pull-request/).
2. Create your feature branch. (`git checkout -b my-new-feature`)
3. Commit your changes. (`git commit -am 'new feature'`)
4. Push the branch. (`git push origin my-new-feature`)
5. Create a new [pull request](https://help.github.com/articles/using-pull-requests).

## Author

* [Jeff Nyman](http://testerstories.com)

## License

Symbiont is distributed under the [MIT](http://www.opensource.org/licenses/MIT) license.
See the [LICENSE](https://github.com/jnyman/symbiont/blob/master/LICENSE.txt) file for details.

## Credits

Thanks to Jeff Morgan ([http://www.cheezyworld.com/](http://www.cheezyworld.com/)) for his [page-object](https://github.com/cheezy/page-object) gem, Alister Scott ([http://watirmelon.com](http://watirmelon.com)) for his [watir-page-helper](https://github.com/alisterscott/watir-page-helper) gem, Alex Rodionov ([http://p0deje.blogspot.com/](http://p0deje.blogspot.com/)) for his [watirsome](https://github.com/p0deje/watirsome) gem, and Nat Ritmeyer ([http://www.natritmeyer.com/](http://www.natritmeyer.com/)) for his [SitePrism](https://github.com/natritmeyer/site_prism/) gem.
