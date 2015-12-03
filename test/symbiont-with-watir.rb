#!/usr/bin/env ruby
$: << './lib'

require 'symbiont'
include Symbiont::Factory

class Symbiote
  attach Symbiont

  url_is 'http://localhost:9292'
  url_matches /:\d{4}/

  element :open_form, id: 'open'

  text_field :username, id: 'username'
  text_field :password, id: 'password'
  button :login, id: 'login-button'
end

class Stardate
  attach Symbiont

  url_is 'http://localhost:9292/stardate'

  elements :facts, css: 'ul#fact-list li a'
end

puts Symbiont.version

Symbiont.set_browser

on_view(Symbiote)
#@page = Symbiote.new
#@page.view

puts "Page displayed? #{@page.displayed?}"

puts "Open Form Element: #{@page.open_form}"
puts "Open Form Exists? #{@page.open_form.exists?}"

puts "Page title: #{@page.title}"
puts "Page URL: #{@page.current_url}"
puts "Page secure? #{@page.secure?}"

on(Symbiote) do
  @page.open_form.click
  @page.username.set 'admin'
  @page.password.set 'admin'
  @page.login.click
end

on_view(Stardate).facts.each { |fact| puts fact.text }
puts "Facts count: #{@page.facts.size}"

Symbiont.browser.quit
