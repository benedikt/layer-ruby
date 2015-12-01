require 'spec_helper'

describe Layer::Client::REST do

  before do
    Layer::Client.configure do |config|
      config.app_id = 'default_app_id'
    end
  end

  subject { described_class.new('default_app_id') }

  describe '.new' do
    before do
      allow(described_class).to receive(:authenticate).and_return('session-token')
    end

    it 'should use to the default app id' do
      expect(subject.app_id).to eq('default_app_id')
    end

    it 'should work with the new id format' do
      client = described_class.new('layer:///apps/staging/custom_app_id') { identity_token }
      expect(client.app_id).to eq('custom_app_id')
    end

    it 'should allow setting a custom app id' do
      client = described_class.new('custom_app_id') { identity_token }
      expect(client.app_id).to eq('custom_app_id')
    end
  end

  %w(get post patch put delete head options).each do |method|
    describe "##{method}" do
      before do
        allow(described_class).to receive(:authenticate).and_return('session-token')
        allow(RestClient::Request).to receive(:execute).and_return('{"foo":"bar"}')
      end

      describe 'result' do
        it 'should parse the JSON result' do
          expect(subject.send(method, '/')).to eq({ 'foo' => 'bar' })
        end

        it 'should return nothing when there is no result' do
          allow(RestClient::Request).to receive(:execute).and_return('')
          expect(subject.send(method, '/')).to_not be
        end
      end

      describe 'method' do
        it "should set the method to #{method.upcase}" do
          subject.send(method, '/')
          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(method: method.to_sym))
        end
      end

      describe 'headers' do
        before do
          subject.send(method, '/', nil, { 'X-Foo' => 'Bar' })
        end

        it 'should set the Authorization header' do
          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(headers: hash_including('Authorization' => 'Layer session-token="session-token"')))
        end

        it 'should set the Accept header' do
          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(headers: hash_including('Accept' => 'application/vnd.layer+json; version=1.0')))
        end

        it 'should set the Content-Type header' do
          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(headers: hash_including('Content-Type' => /application\/(json|vnd\.layer-patch\+json)/)))
        end

        it 'should set the If-None-Match header' do
          pattern = /[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/

          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(headers: hash_including('If-None-Match' => pattern)))
        end

        it 'should allow additional headers' do
          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(headers: hash_including('X-Foo' => 'Bar')))
        end
      end

      describe 'payload' do
        before do
          subject.send(method, '/', { :foo => 'bar' })
        end

        it 'should convert the payload to JSON' do
          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(payload: '{"foo":"bar"}'))
        end
      end

      describe 'url' do
        it 'should prepend the base url when given a path' do
          subject.send(method, '/conversations')

          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(url: 'https://api.layer.com/conversations'))
        end

        it 'should not modify the url when given a layer api url' do
          subject.send(method, 'https://api.layer.com/conversations')

          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(url: 'https://api.layer.com/conversations'))
        end
      end
    end
  end
end
