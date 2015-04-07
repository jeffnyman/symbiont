module Symbiont
  module WorkflowPaths
    def paths
      @paths
    end

    def paths=(path)
      @paths = path
    end

    def path_data
      @path_data
    end

    def path_data=(data)
      @path_data = data
    end
  end

  module Workflow
    def self.included(caller)
      caller.extend WorkflowPaths
      @def_caller = caller
    end

    def self.def_caller
      @def_caller
    end

    # Provides a workflow for a given workflow path, using a specific
    # definition that is part of that workflow path.
    #
    # @param definition [Object] definition object using the workflow
    # @param path_name [Hash] the name of the path to be used
    # @param block [Proc] a block to be executed as part of the workflow
    # @return [Object] the definition being interacted with
    def workflow_for(definition, path_name = {:using => :default}, &block)
      path_name[:using] = :default unless path_name[:using]
      path_workflow = workflow_path_for(path_name)

      workflow_goal = work_item_index_for(path_workflow, definition) - 1

      if workflow_goal == -1
        return on(definition, &block)
      else
        workflow_start = path_name[:from] ? path_workflow.find_index { |item| item[0] == path_name[:from] } : 0
        perform_workflow(path_workflow[workflow_start..workflow_goal])
      end

      on(definition, &block)
    end

    private

    def perform_workflow(definitions)
      definitions.each do |definition, action, *args|
        active = on(definition)

        raise Symbiont::Errors::WorkflowActionNotFound,
            "Workflow action '#{action}' not defined on #{definition}." unless active.respond_to? action

        active.send action unless args
        active.send action, *args if args
      end
    end

    def workflow_path_for(path_name)
      # Since I'm dealing with an array that contains a hash that, in turn,
      # contains an array of arrays, I need to make sure that I index into
      # the array before keying into the hash. That's the purpose of the [0].
      path = Workflow.def_caller.paths[path_name[:using]]

      raise Symbiont::Errors::WorkflowPathNotFound,
          "Workflow path '#{path_name[:using].to_s}' not found." unless path

      if Workflow.def_caller.path_data
        file_to_load = Workflow.def_caller.path_data[path_name[:using]]
        DataBuilder.load "#{file_to_load.to_s}.yml" if file_to_load
      end

      path
    end

    def work_item_index_for(path_workflow, definition)
      path_workflow.find_index { |item| item[0] == definition }
    end
  end
end