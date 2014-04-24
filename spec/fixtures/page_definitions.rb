class PageWithMissingAssertions
  attach Symbiont
end

class ValidPage
  attach Symbiont
  
  url_is 'http://localhost:9292'
  url_matches /:\d{4}/
  title_is 'Dialogic'
end
