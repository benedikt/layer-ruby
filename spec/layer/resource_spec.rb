require 'spec_helper'

describe Layer::Resource do

  let(:dummy_resource) do
    Class.new(Layer::Resource) do
      def self.name
        "Layer::Object"
      end
    end
  end

  let(:client) { double(:client) }
  let(:attributes) do
    {
      'id' => 'layer:///resources/1',
      'url' => 'https://api.layer.com/apps/default_app_id/resources/1',
      'foo' => 'bar'
    }
  end

  subject { dummy_resource.new(attributes, client) }

  describe '.class_name' do
    it 'should drop the namespace' do
      expect(dummy_resource.class_name).to eq('Object')
    end
  end

  describe '.url' do
    it 'should infer the url from the name' do
      expect(dummy_resource.url).to eq('/objects')
    end
  end

  describe '.from_response' do

    it 'should require attributes' do
      expect { dummy_resource.from_response }
        .to raise_error(ArgumentError)
    end

    it 'should require a client' do
      expect { dummy_resource.from_response({}) }
        .to raise_error(ArgumentError)
    end

    it 'should store the attributes' do
      resource = dummy_resource.from_response(attributes, client)
      expect(resource.foo).to eq('bar')
    end
  end

  describe '#id' do
    it 'should always be callable' do
      expect(dummy_resource.new.id).to eq(nil)
    end

    it 'should return the id' do
      expect(subject.id).to eq('layer:///resources/1')
    end
  end

  describe '#url' do
    it 'should always be callable' do
      expect(dummy_resource.new.url).to eq(nil)
    end

    it 'should return the url' do
      expect(subject.url).to eq('https://api.layer.com/apps/default_app_id/resources/1')
    end
  end

  describe 'additional methods' do
    context 'when there is an corresponding attribute' do
      it 'should return the attribute\'s value' do
        expect(subject.foo).to eq('bar')
      end
    end

    context 'when the attribute is not available' do
      it 'should raise a NoMethodError' do
        expect { subject.bar }.to raise_error(NoMethodError)
      end
    end

    context 'when trying to set an attribute' do
      it 'should set the attribute' do
        subject.foo = 'bar'
        expect(subject.foo).to eq('bar')
      end
    end
  end
end
