require 'spec_helper'

class TestService
  include Symbiont::SoapObject

  wsdl 'http://www.webservicex.net/MortgageIndex.asmx?WSDL'
  proxy 'http://corporate-proxy.com:9292'
  basic_auth 'jnyman', 'lucid'
  digest_auth 'admin', 'secret'
  soap_header :auth_token => 'secret'
  encoding 'UTF-16'
  open_timeout 10
  read_timeout 20
  log_level :info
end

class TestSimpleService
  include Symbiont::SoapObject
end

class TestSSLService
  include Symbiont::SoapObject

  ssl_version :SSLv2
  ssl_verification true
end

class TestNoSSLService
  include Symbiont::SoapObject

  ssl_verification false
end

describe Symbiont::SoapObject do
  let(:client) { double('client') }
  let(:subject) { TestService.new }

  context 'when using a soap-based service object' do
    before do
      allow(Savon).to receive(:client).and_return(client)
    end

    it 'will initialize the client using a wsdl' do
      expect(subject.send(:client_properties)[:wsdl]).to eq('http://www.webservicex.net/MortgageIndex.asmx?WSDL')
    end

    it 'will know if it is connected to a service' do
      expect(subject).to be_connected
    end

    it 'will be able to discover soap operations' do
      expect(client).to receive(:to).and_return(client)
      expect(client).to receive(:operations).and_return(client)
      expect(subject.send(:operations).to include :get_mortgage_index_by_month)
    end

    it 'will accept an encoding parameter' do
      expect(subject.send(:client_properties)[:encoding]).to eq('UTF-16')
    end

    it 'will respect an open timeout' do
      expect(subject.send(:client_properties)[:open_timeout]).to eq(10)
    end

    it 'will respect a read timeout' do
      expect(subject.send(:client_properties)[:read_timeout]).to eq(20)
    end

    it 'will utilize a proxy' do
      expect(subject.send(:client_properties)[:proxy]).to eq('http://corporate-proxy.com:9292')
    end

    it 'will allow the use of basic authentication' do
      expect(subject.send(:client_properties)[:basic_auth]).to eq(['jnyman', 'lucid'])
    end

    it 'will allow the use of digest authentication' do
      expect(subject.send(:client_properties)[:digest_auth]).to eq(['admin', 'secret'])
    end

    it 'will pass in a soap header' do
      expect(subject.send(:client_properties)[:soap_header]).to eq({:auth_token => 'secret'})
    end

    context 'logging' do
      it 'will enable logging when a logging level is set' do
        expect(subject.send(:client_properties)[:log]).to eq(true)
      end

      it 'will allow the log level to be set' do
        expect(subject.send(:client_properties)[:log_level]).to eq(:info)
      end

      it 'logging is disabled by default' do
        expect(TestSimpleService.new.send(:client_properties)[:log]).to eq(false)
      end

      it 'will use the preetty format for xml when logging' do
        expect(subject.send(:client_properties)[:pretty_print_xml]).to eq(true)
      end
    end

    context 'ssl' do
      it 'will set SSL version to 3 by default' do
        expect(subject.send(:client_properties)[:ssl_version]).to eq(:SSLv3)
      end

      it 'will allow the SSL version to be set' do
        expect(TestSSLService.new.send(:client_properties)[:ssl_version]).to eq(:SSLv2)
      end

      it 'will disable SSL verification by default' do
        expect(subject.send(:client_properties)[:ssl_verify_mode]).to eq(:none)
      end

      it 'will allow SSL verification to be enabled' do
        expect(TestSSLService.new.send(:client_properties)[:ssl_verify_mode]).to eq(true)
      end

      it 'will allow SSL verification to be explicitly disabled' do
        expect(TestNoSSLService.new.send(:client_properties)[:ssl_verify_mode]).to eq(:none)
      end
    end

    context 'calling methods on the service' do
      let(:response) { double('response') }

      before do
        allow(Savon).to receive(:client).and_return(client)
        allow(response).to receive(:to_xml)
      end

      it 'will make a valid request to the service with a message' do
        expect(client).to receive(:call).with(:mock_call, message: {word: 'lucid'}).and_return(response)
        subject.mock_call word: 'lucid'
      end

      it 'will make a valid request to the service with xml' do
        xml = '<xml><envelope><data></data></envelope></xml>'
        expect(client).to receive(:call).with(:mock_call, xml: xml).and_return(response)
        subject.mock_call xml
      end

      it 'will be able to get a doc representation' do
        expect(client).to receive(:call).with(:mock_call, message: {word: 'lucid'}).and_return(response)
        allow(response).to receive(:doc)
        subject.mock_call word: 'lucid'
        subject.doc
      end

      it 'will be able to get the body of the response' do
        expect(client).to receive(:call).with(:mock_call, message: {word: 'lucid'}).and_return(response)
        allow(response).to receive(:body)
        subject.mock_call word: 'lucid'
        subject.body
      end

      it 'will be able to get an xml representation' do
        expect(client).to receive(:call).with(:mock_call, message: {word: 'lucid'}).and_return(response)
        allow(response).to receive(:to_xml)
        subject.mock_call word: 'lucid'
        subject.to_xml
      end

      it 'will be able to get a hash representation' do
        expect(client).to receive(:call).with(:mock_call, message: {word: 'lucid'}).and_return(response)
        allow(response).to receive(:to_hash)
        subject.mock_call word: 'lucid'
        subject.to_hash
      end

      it 'will be able to get information from the response via xpath' do
        expect(client).to receive(:call).with(:mock_call, message: {word: 'lucid'}).and_return(response)
        allow(response).to receive(:xpath)
        subject.mock_call word: 'lucid'
        subject.xpath('//Lucid/testing')
      end
    end
  end
end