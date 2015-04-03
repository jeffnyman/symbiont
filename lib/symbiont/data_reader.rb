module Symbiont
  module DataReader

    def data_path=(path)
      @data_path = path
    end

    def data_path
      return @data_path if @data_path
      return default_data_path if self.respond_to? :default_data_path
      nil
    end

    # The data_source name here must match the name used for the
    # class accessor in the data builder. It is this data_source
    # variable that connects the reader and the builder.
    def load(file)
      @data_source = YAML.load_file "#{data_path}/#{file}"
    end
    
  end
end
