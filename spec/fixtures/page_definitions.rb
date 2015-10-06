class PageWithMissingAssertions
  attach Symbiont
end

class TestFactory
  include Symbiont::Factory
  attr_accessor :browser
  attr_accessor :page
end

class ValidPageNewContext
  attach Symbiont
end

class ValidPage
  attach Symbiont

  url_is 'http://localhost:9292'
  url_matches /:\d{4}/
  title_is 'Symbiote'

  %w(text_field button file_field textarea select_list checkbox).each do |element|
    send element, :"#{element}", id: element

    send element, :"#{element}_proc", proc { browser.send(element, id: element) }
    send element, :"#{element}_lambda", -> { browser.send(element, id: element) }

    send element, :"#{element}_block" do
      browser.send(element, id: element)
    end

    send element, :"#{element}_block_arg" do |id|
      browser.send(element, id: id)
    end
  end
end
