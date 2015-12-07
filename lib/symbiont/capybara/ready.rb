module Symbiont
  module Ready
    module ClassMethods
      def ready_validations
        if superclass.respond_to?(:ready_validations)
          superclass.ready_validations + _ready_validations
        else
          _ready_validations
        end
      end

      def page_ready(&block)
        _ready_validations << block
      end

      alias_method :page_ready_when, :page_ready

      def _ready_validations
        @_ready_validations ||= []
      end
    end

    attr_accessor :ready, :ready_error

    def self.included(caller)
      caller.extend(ClassMethods)
    end

    def when_ready(&block)
      already_marked_ready = ready

      fail(ArgumentError, 'A block is required for a when_ready action.') unless block_given?

      unless self.ready = ready?
        message = "Failed to validate because: #{ready_error || 'no reason provided'}"
        fail(::Symbiont::Errors::PageNotValidatedError, message)
      end
      block.call self
    ensure
      self.ready = already_marked_ready
    end

    def ready?
      self.ready_error = nil
      return true if ready
      ready_validations_pass?
    end

    def ready_validations_pass?
      self.class.ready_validations.all? do |validation|
        passed, message = instance_eval(&validation)
        self.ready_error = message if message && !passed
        passed
      end
    end
  end
end
