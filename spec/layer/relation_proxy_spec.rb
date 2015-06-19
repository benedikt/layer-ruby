require 'spec_helper'

describe Layer::RelationProxy do

  let(:base) { double(:base, url: '/conversations/1') }
  let(:resource_type) { double(:resource_type, url: '/messages') }
  let(:operations) { [Layer::Operations::Find, Layer::Operations::Create] }

  subject { described_class.new(base, resource_type, operations) }

  describe '#new' do
    it 'should require a base' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it 'should require a resource type' do
      expect { described_class.new(base) }.to raise_error(ArgumentError)
    end

    it 'should not include any operations by default' do
      proxy = described_class.new(base, resource_type)
      operations = proxy.singleton_class.ancestors.map(&:name).grep(/Layer::Operations/)
      expect(operations).to be_empty
    end

    it 'should include the given operations' do
      expect(subject.singleton_class.ancestors)
        .to include(Layer::Operations::Find::ClassMethods, Layer::Operations::Create::ClassMethods)
    end
  end

  describe '.url' do
    it 'should combine the urls of base and resource type' do
      expect(subject.url).to eq('/conversations/1/messages')
    end
  end

  describe 'missing methods' do
    it 'should delegate missing methods to the resource type when they exist' do
      expect(resource_type).to receive(:from_response)
      subject.from_response
    end

    it 'should raise a NoMethodError when the method does not exist' do
      expect { subject.foo }.to raise_error(NoMethodError)
    end
  end
end
