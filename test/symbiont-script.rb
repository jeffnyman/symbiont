#!/usr/bin/env ruby
$: << './lib'

require 'rspec'
include RSpec::Matchers

require 'watir-webdriver'

require 'symbiont'
include Symbiont::Factory

#========================================

class SoapService
  include Symbiont::SoapObject

  wsdl 'http://services.aonaware.com/DictService/DictService.asmx?WSDL'
  log_level :info

  def definition_for(word)
    define word: word
  end
end

class Dialogic
  attach Symbiont

  url_is 'http://localhost:9292'

  p          :login_form, id: 'open'
  text_field :username,   id: 'username'
  text_field :password,   id: 'password'
  button     :login,      id: 'login-button'

  def login_as_admin
    login_form.click
    username.set 'admin'
    password.set 'admin'
    login.click
  end
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

  checkbox :enable_sith_list, id: 'toggleSith'
  select_list :sith_power, id: 'sith'
  select_list :physics_concept, id: 'physics'

  button :alert,   id: 'alertButton'
  button :confirm, id: 'confirmButton'
  button :prompt,  id: 'promptButton'

  link :view_in_frame, id: 'framed_page'

  iframe :boxframe, class: 'fancybox-iframe'

  text_field :weight, -> { boxframe.text_field(id: 'wt') }

  article :practice, id: 'practice'

  a :page_link do |text|
    practice.a(text: text)
  end
end

def non_framed
  @page = Weight.new(@driver)
  @page.view
  @page.weight.set '200'
  @page.calculate.click
end

def framed
  @page = Practice.new(@driver)
  @page.view
  ##@page.view_in_frame.click
  @page.page_link('View Weight Calculator in Frame').click
  @page.weight.set '200'

  ##on_view(Practice).page_link('View Weight Calculator in Frame').click
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

  expect(@page.url).to eq('http://localhost:9292/practice')
  @page.markup.include?('<strong id="group">Apocalypticists Unite</strong>').should be_true
  @page.text.include?('LEAST FAVORITE WAY').should be_true
  expect(@page.title).to eq('Dialogic - Practice Page')

  script = <<-JS
    return arguments[0].innerHTML
  JS

  result = @page.run_script(script, @page.view_in_frame)
  expect(result).to eq('View Weight Calculator in Frame')
end

def factory
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
end

def javascript_dialogs
  response = @page.will_alert { @page.alert.click }
  expect(response).to eq 'Alert Message Received'

  response = @page.will_confirm(false) { @page.confirm.click }
  expect(response).to eq 'Confirmation Message Received'

  response = @page.will_prompt("magenta") { @page.prompt.click }
  expect(response[:message]).to eq('Favorite Color')
  expect(response[:default_value]).to eq('blue')
end

def wait_state
  Watir::Wait.until { @page.weight.exists? }
  @page.weight.when_present.set '200'
end

#basic

#symbiont_browser

#@page = Dialogic.new(@browser)
#@page.view
#@page.login_as_admin

#@page = Practice.new(@browser)
#@page.view
#@page.enable_sith_list.set
#@page.sith_power.select 'Sundering Assault'

@service = SoapService.new
#puts @service.connected?
#puts @service.operations
#@service.define(word: 'lucid')
@service.definition_for('lucid')
#puts @service.doc
#puts @service.to_xml
#puts @service.to_hash
#puts @service.body