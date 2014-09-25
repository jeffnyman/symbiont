[![Stories in Ready](https://badge.waffle.io/jnyman/symbiont.png?label=ready&title=Ready)](https://waffle.io/jnyman/symbiont)
# Symbiont

[![Gem Version](https://badge.fury.io/rb/symbiont.svg)](http://badge.fury.io/rb/symbiont)
[![Build Status](https://secure.travis-ci.org/jnyman/symbiont.png)](http://travis-ci.org/jnyman/symbiont)
[![Coverage Status](https://coveralls.io/repos/jnyman/symbiont/badge.png?branch=master)](https://coveralls.io/r/jnyman/symbiont?branch=master)
[![Code Climate](https://codeclimate.com/github/jnyman/symbiont.png)](https://codeclimate.com/github/jnyman/symbiont)
[![Dependency Status](https://gemnasium.com/jnyman/symbiont.png)](https://gemnasium.com/jnyman/symbiont)

Symbiont provides a semantic domain-specific language that can be used to construct a fluent interface for test execution libraries. The initial focus will be on using the [watir-webdriver](https://github.com/watir/watir-webdriver) API as the underlying driver library.

[![Gitter chat](https://badges.gitter.im/jnyman/symbiont.png)](https://gitter.im/jnyman/symbiont)
[![endorse](https://api.coderwall.com/jnyman/endorsecount.png)](https://coderwall.com/jnyman)
[![Stories in Ready](https://badge.waffle.io/jnyman/symbiont.png?label=ready&title=Ready)](https://waffle.io/jnyman/symbiont)


## What is this?

Symbiont is a test solution micro-framework.

A micro-framework provides a focused solution, which means it does one thing and one thing only, instead of trying to solve each and every problem. While doing that one thing it does well, the micro-framework should do it while being expressive and concise. Further, it should be able to serve as one component of your own custom modularized framework, allowing you to compose solutions.

To that end, you can use Symbiont directly as an automated test library or you can use it with other tools such as [RSpec](http://rspec.info/), [Cucumber](http://cukes.info/), or my own [Lucid](https://github.com/jnyman/lucid) tool.

In terms of what Symbiont does, it provides a way to describe your application in terms of activity and page definitions. Those definitions can then be referenced by the [Watir-WebDriver test library](https://github.com/watir/watir-webdriver) using the DSL and API that Symbiont provides. The DSL provides a fluent interface that can be used for constructing test execution logic. This fluent interface promotes the idea of compressibility of your test logic, allowing for more factoring, more reuse, and less repetition.


## Installation

You can use Symbiont as part of another project, in which case you can add the following to your Gemfile:

    gem 'symbiont'

And then execute:

    $ bundle

You can also install Symbiont just as you would any other gem:

    $ gem install symbiont

## Usage

To learn how to use the framework, you can check out my [blog posts on Symbiont](http://testerstories.com/category/symbiont/).

You can check out the [Symbiont test script](https://github.com/jnyman/symbiont/blob/master/test/symbiont-script.rb) for an idea of how the library can be interacted with. Do note that the test script requires a local copy of [Dialogic](https://github.com/jnyman/dialogic) to be running. To execute the test script:

    $ rake test:script

## Why call it Symbiont?

A "symbiont" is an organism in a symbiotic (mutually beneficial) relationship. Some of these relationships are called _obligate_, which means that both organisms need each other in order to survive. Other such relationships are called _facultative_, meaning that both organisms don't strictly need each other to survive, but they stand a better chance if they do.

Symbiotic relationships include associations in which one organism lives on another organism -- _ectosymbiosis_ -- or where one organism lives inside the other -- _endosymbiosis_.

So, with that bit of context, think of this library as a facultative, endosymbiotic organism that lives within your test logic, giving it strength and sustenance.

## Contributing

1. [Fork the project](http://gun.io/blog/how-to-github-fork-branch-and-pull-request/).
2. Create a feature branch. (`git checkout -b my-new-feature`)
3. Commit your changes. (`git commit -am 'new feature'`)
4. Push the branch. (`git push origin my-new-feature`)
5. Create a new [pull request](https://help.github.com/articles/using-pull-requests).

## Credits

Thanks to Jeff Morgan ([http://www.cheezyworld.com/](http://www.cheezyworld.com/)) for his [page-object](https://github.com/cheezy/page-object) gem, Alister Scott ([http://watirmelon.com](http://watirmelon.com)) for his [watir-page-helper](https://github.com/alisterscott/watir-page-helper) gem, Alex Rodionov ([(http://p0deje.blogspot.com/](http://p0deje.blogspot.com/)) for his [watirsome](https://github.com/p0deje/watirsome) gem, and Nat Ritmeyer ([http://www.natritmeyer.com/](http://www.natritmeyer.com/)) for his [SitePrism](https://github.com/natritmeyer/site_prism/) gem.

## Copyright

Symbiont is distributed under the MIT license. See the [LICENSE](https://github.com/jnyman/symbiont/blob/master/LICENSE.txt) file for details.
