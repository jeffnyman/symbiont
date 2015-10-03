module Symbiont
  module SoapObject
    module SoapMethods
      def wsdl(url)
        define_method(:has_wsdl) do
          @wsdl ||= url
          { wsdl: @wsdl }
        end
      end

      def proxy(url)
        define_method(:has_proxy) do
          { proxy: url }
        end
      end

      def basic_auth(*creds)
        define_method(:has_basic_auth) do
          { basic_auth: creds }
        end
      end

      def digest_auth(*creds)
        define_method(:has_digest_auth) do
          { digest_auth: creds }
        end
      end

      def soap_header(header)
        define_method(:has_soap_header) do
          { soap_header: header }
        end
      end

      def encoding(enc)
        define_method(:has_encoding) do
          { encoding: enc }
        end
      end

      def open_timeout(timeout)
        define_method(:has_open_timeout) do
          { open_timeout: timeout }
        end
      end

      def read_timeout(timeout)
        define_method(:has_read_timeout) do
          { read_timeout: timeout }
        end
      end

      def log_level(level)
        define_method(:has_log_level) do
          { log: true, log_level: level, pretty_print_xml: true }
        end
      end

      def ssl_version(version)
        define_method(:has_ssl_version) do
          { ssl_version: version }
        end
      end

      def ssl_verification(enable)
        return unless enable
        define_method(:has_ssl_verification) do
          { ssl_verify_mode: true }
        end
      end
    end
  end
end
