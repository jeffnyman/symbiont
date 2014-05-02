# Symbiont

[![Gem Version](https://badge.fury.io/rb/symbiont.svg)](http://badge.fury.io/rb/symbiont)
[![Build Status](https://secure.travis-ci.org/jnyman/symbiont.png)](http://travis-ci.org/jnyman/symbiont)
[![Coverage Status](https://coveralls.io/repos/jnyman/symbiont/badge.png)](https://coveralls.io/r/jnyman/symbiont)
[![Code Climate](https://codeclimate.com/github/jnyman/symbiont.png)](https://codeclimate.com/github/jnyman/symbiont)
[![Dependency Status](https://gemnasium.com/jnyman/symbiont.png)](https://gemnasium.com/jnyman/symbiont)

Symbiont provides a semantic domain-specific language that can be used to construct a fluent interface for test execution libraries. The initial focus will be on using the [watir-webdriver](https://github.com/watir/watir-webdriver) API as the underlying driver library.

[![Gitter chat](https://badges.gitter.im/jnyman/symbiont.png)](https://gitter.im/jnyman/symbiont)
[![endorse](https://api.coderwall.com/jnyman/endorsecount.png)](https://coderwall.com/jnyman)


## Installation

You can use Symbiont as part of another project, in which case you can add the following to your Gemfile:

    gem 'symbiont'

And then execute:

    $ bundle

You can also install Symbiont just as you would any other gem:

    $ gem install symbiont

## Usage

Instructions on how to use Symbiont will be available as the interface is defined.

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
