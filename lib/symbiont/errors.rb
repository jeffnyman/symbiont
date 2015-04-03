module Symbiont
  module Errors
    class NoUrlForDefinition < StandardError; end
    class NoUrlMatchForDefinition < StandardError; end
    class NoTitleForDefinition < StandardError; end
    class WorkflowPathNotFound < StandardError; end
    class WorkflowActionNotFound < StandardError; end
  end
end
