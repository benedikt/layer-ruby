require 'spec_helper'

describe Layer::Client do
  describe 'default configuration' do
    describe '.app_id' do
      before do
        ENV['LAYER_APP_ID'] = 'layer_app_id'
      end

      it 'should default to LAYER_APP_ID environment variable' do
        expect(Layer::Client.app_id).to eq('layer_app_id')
      end

      it 'should be configurable' do
        Layer::Client.app_id = 'custom_app_id'
        expect(Layer::Client.app_id).to eq('custom_app_id')
      end
    end

    describe '.token' do
      before do
        ENV['LAYER_PLATFORM_TOKEN'] = 'layer_platform_token'
      end

      it 'should default to LAYER_APP_ID environment variable' do
        expect(Layer::Client.token).to eq('layer_platform_token')
      end

      it 'should be configurable' do
        Layer::Client.token = 'custom_platform_token'
        expect(Layer::Client.token).to eq('custom_platform_token')
      end
    end

    describe '.configure' do
      it 'should yield the client' do
        expect { |block| described_class.configure(&block) }
          .to yield_with_args(described_class)
      end
    end
  end

  describe '.new' do
    before do
      described_class.configure do |config|
        config.app_id = 'default_app_id'
        config.token = 'default_platform_token'
      end
    end

    it 'should use to the default app id' do
      expect(subject.app_id).to eq('default_app_id')
    end

    it 'should use to the default plattform token' do
      expect(subject.token).to eq('default_platform_token')
    end

    it 'should allow setting a custom app id and token' do
      client = described_class.new('custom_app_id', 'custom_platform_token')
      expect(client.app_id).to eq('custom_app_id')
      expect(client.token).to eq('custom_platform_token')
    end
  end

  %w(get post patch put delete head options).each do |method|
    describe "##{method}" do
      before do
        described_class.configure do |config|
          config.app_id = 'default_app_id'
          config.token = 'default_platform_token'
        end
      end

      before do
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
            .with(hash_including(headers: hash_including('Authorization' => 'Bearer default_platform_token')))
        end

        it 'should set the Accept header' do
          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(headers: hash_including('Accept' => 'application/vnd.layer+json; version=1.0')))
        end

        it 'should set the Content-Type header' do
          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(headers: hash_including('Content-Type' => 'application/json')))
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
            .with(hash_including(url: 'https://api.layer.com/apps/default_app_id/conversations'))
        end

        it 'should not modify the url when given a layer api url' do
          subject.send(method, 'https://api.layer.com/apps/default_app_id/conversations')

          expect(RestClient::Request).to have_received(:execute)
            .with(hash_including(url: 'https://api.layer.com/apps/default_app_id/conversations'))
        end
      end
    end
  end
end