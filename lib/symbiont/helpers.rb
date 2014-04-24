module Symbiont
  module Helpers
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

    private

    def retrieve_class(caller)
      caller[1][/`.*'/][8..-3]
    end
  end
end
