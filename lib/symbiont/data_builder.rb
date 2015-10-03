module Symbiont
  module DataBuilder
    extend DataReader

    class << self
      attr_accessor :data_source

      def default_data_path
        'data'
      end
    end

    def data_about(key, specified = {})
      if key.is_a?(String) && key.match(%r{/})
        file, record = key.split('/')
        DataBuilder.load("#{file}.yml")
      else
        record = key.to_s
        DataBuilder.load('default.yml')
      end

      Symbiont.trace("DataBuilder.data_source = #{DataBuilder.data_source}")

      data = DataBuilder.data_source[record]
      raise ArgumentError, "Undefined key for data: #{key}" unless data

      data.merge(specified)
    end

    alias_method :data_from,       :data_about
    alias_method :data_for,        :data_about
    alias_method :using_data_for,  :data_about
    alias_method :using_data_from, :data_about
  end
end
