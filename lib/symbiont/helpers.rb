module Symbiont
  module Helpers
    private

    def url_is_empty
      puts "\nERROR".on_red
      puts "The url_is assertion is empty on the definition #{retrieve_class(caller)}.".cyan
      raise Symbiont::Errors::NoUrlForDefinition
    end

    def url_match_is_empty
      puts "\nERROR".on_red
      puts "The url_matches assertion is empty on the definition #{retrieve_class(caller)}.".cyan
      raise Symbiont::Errors::NoUrlMatchForDefinition
    end

    def title_is_empty
      puts "\nERROR".on_red
      puts "The title_is assertion is empty on the definition #{retrieve_class(caller)}.".cyan
      raise Symbiont::Errors::NoTitleForDefinition
    end

    def no_url_is_provided
      puts "\nERROR".on_red
      puts "You called a '#{retrieve_method(caller)}' action but the \
        definition #{self.class} does not have a url_is assertion.".cyan
      raise Symbiont::Errors::NoUrlForDefinition
    end

    def no_url_matches_is_provided
      puts "\nERROR".on_red
      puts "You called a '#{retrieve_method(caller)}' action but the \
        definition #{self.class} does not have a url_matches assertion.".cyan
      raise Symbiont::Errors::NoUrlMatchForDefinition
    end

    def no_title_is_provided
      puts "\nERROR".on_red
      puts "You called a '#{retrieve_method(caller)}' action but the \
        definition #{self.class} does not have a title_is assertion.".cyan
      raise Symbiont::Errors::NoTitleForDefinition
    end

    def retrieve_class(caller)
      caller[1][/`.*'/][8..-3]
    end

    def retrieve_method(caller)
      caller[0][/`.*'/][1..-2]
    end
  end
end
