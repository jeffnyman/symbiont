require 'savon'
require 'symbiont/soap_methods'

module Symbiont
  module SoapObject
    attr_reader :response

    def self.included(caller)
      caller.extend SoapMethods
    end

    def initialize
      @client = Savon.client(client_properties)
    end

    def connected?
      !@client.nil?
    end

    def operations
      @client.operations
    end

    def doc
      response.doc
    end

    def body
      response.body
    end

    def xpath(node)
      response.xpath(node)
    end

    def to_xml
      response.to_xml
    end

    def to_hash
      response.hash
    end

    private

    def method_missing(*args)
      operation = args.shift
      message = args.shift
      type = message.is_a?(String) ? :xml : :message
      call(operation, type => message)
    end

    def call(operation, data)
      @response = @client.call(operation, data)
      response.to_xml
    end

    def client_properties
      properties = { log: false, ssl_version: :SSLv3, ssl_verify_mode: :none }
      [
        :has_wsdl,
        :has_proxy,
        :has_basic_auth,
        :has_digest_auth,
        :has_encoding,
        :has_soap_header,
        :has_open_timeout,
        :has_read_timeout,
        :has_log_level,
        :has_ssl_version,
        :has_ssl_verification,
      ].each do |sym|
        properties = properties.merge(send sym) if self.respond_to? sym
      end
      properties
    end
  end
end
