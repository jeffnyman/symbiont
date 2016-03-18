#!/usr/bin/env ruby
$: << './lib'

require 'symbiont'
include Symbiont::Factory

class Decohere
  attach Symbiont

  url_is 'https://decohere.herokuapp.com/'
  url_matches /decohere/

  element    :open_form, id: 'openLogin'

  text_field :username,  id: 'username'
  text_field :password,  id: 'password'
  button     :login,     id: 'login'
end

class Stardate
  attach Symbiont

  url_is 'https://decohere.herokuapp.com/stardate'

  elements :facts, css: 'ul#fact-list li a'
end

puts Symbiont.version

Symbiont.set_browser

on_view(Decohere)

puts "Page displayed? #{@page.displayed?}"

puts "Open Form Element: #{@page.open_form}"
puts "Open Form Exists? #{@page.open_form.exists?}"

puts "Page title: #{@page.title}"
puts "Page URL: #{@page.current_url}"
puts "Page secure? #{@page.secure?}"

on(Decohere) do
  @page.open_form.click
  @page.username.set 'admin'
  @page.password.set 'admin'
  @page.login.click
end

on_view(Stardate).facts.each { |fact| puts fact.text }
puts "Facts count: #{@page.facts.size}"

Symbiont.browser.quit
