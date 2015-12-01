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
        expect { |block| Layer::Client.configure(&block) }
          .to yield_with_args(described_class)
      end
    end
  end
end
