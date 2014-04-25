#!/usr/bin/env ruby
$: << './lib'

require 'rspec'
include RSpec::Matchers

require 'watir-webdriver'

require 'symbiont'

#========================================

class Practice
  attach Symbiont

  url_is 'http://localhost:9292/practice'
  url_matches /:\d{4}/
  title_is 'Dialogic - Practice Page'
end

driver = Watir::Browser.new

@page = Practice.new(driver)
@page.should be_a_kind_of(Symbiont)
@page.should be_an_instance_of(Practice)

@page.view
@page.has_correct_url?
@page.has_correct_title?

@page.should have_correct_url
@page.should have_correct_title
