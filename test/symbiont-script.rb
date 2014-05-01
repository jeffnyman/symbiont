#!/usr/bin/env ruby
$: << './lib'

require 'rspec'
include RSpec::Matchers

require 'watir-webdriver'

require 'symbiont'
include Symbiont::Factory

#========================================

class Dialogic
  attach Symbiont

  url_is 'http://localhost:9292'
end

class Weight
  attach Symbiont

  url_is 'http://localhost:9292/weight'

  text_field :weight,    id: 'wt', index: 0
  button     :calculate, id: 'calculate'

  def convert(value)
    weight.set value
  end
end

class Practice
  attach Symbiont

  url_is 'http://localhost:9292/practice'
  url_matches /:\d{4}/
  title_is 'Dialogic - Practice Page'

  link :view_in_frame, id: 'framed_page'

  iframe :boxframe, class: 'fancybox-iframe'

  text_field :weight, -> { boxframe.text_field(id: 'wt') }

  article :practice, id: 'practice'

  a :page_link do |text|
    practice.a(text: text)
  end
end

@driver = Watir::Browser.new

def non_framed
  @page = Weight.new(@driver)
  @page.view
  @page.weight.set '200'
  @page.calculate.click
end

def framed
  @page = Practice.new(@driver)
  @page.view
  #@page.view_in_frame.click
  @page.page_link('View Weight Calculator in Frame').click
  @page.weight.set '200'
end

def basic
  @page = Practice.new(@driver)  
  @page.should be_a_kind_of(Symbiont)
  @page.should be_an_instance_of(Practice)

  @page.view
  @page.has_correct_url?
  @page.has_correct_title?

  @page.should have_correct_url
  @page.should have_correct_title
end

#basic

on_view(Weight)
on(Weight).convert('200')
on(Weight).calculate.click

on(Weight) do
  @active.convert('200')
  @active.calculate.click
end

on(Weight) do |page|
  page.convert('200')
  page.calculate.click
end
