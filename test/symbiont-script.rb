#!/usr/bin/env ruby
$: << './lib'

require 'rspec'
include RSpec::Matchers

require 'symbiont'

class Symbiote
  attach Symbiont

  url_is 'http://localhost:9292'
  url_matches /:\d{4}/

  p :open_form, id: 'open'
  text_field :username, id: 'username'
  text_field :password, id: 'password'
  button :login, id: 'login-button'

  text_fields :settings
end

Symbiont.set_browser

puts Symbiont.version

page = Symbiote.new
page.view

puts page.displayed?
puts page.open_form
puts page.open_form.exists?

puts page.title
puts page.current_url
puts page.secure?

page.open_form.click
page.username.set 'admin'
page.password = 'admin'
page.login.click
