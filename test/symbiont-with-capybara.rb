#!/usr/bin/env ruby
$: << './lib'

require 'symbiont'
include Symbiont::Factory

Capybara.configure do |config|
  config.default_driver = :selenium
  config.app_host = 'http://localhost:9292'
end

class Symbiote < Symbiont::Page
  url_is '/'
  url_matches /:\d{4}/
end

puts Symbiont.version

@page = Symbiote.new
@page.view

puts "Page displayed? #{@page.displayed?}"

puts "Page title: #{@page.title}"
puts "Page URL: #{@page.current_url}"
puts "Page secure? #{@page.secure?}"
