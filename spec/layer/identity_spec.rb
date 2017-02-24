require 'spec_helper'

describe Layer::Identity do

  let(:client) { instance_double('Layer::Client') }
  let(:response) do
    {
      'display_name' => 'Foo Bar',
    }
  end

  subject { described_class.from_response(response, client) }

  describe 'attributes' do
    it 'should return the attribute with the given name' do
      expect(subject.display_name).to eq('Foo Bar')
    end
  end

  describe '#metadata' do
    context 'when there already is metadata' do
      let(:response) do
        {
          'metadata' => {
            'foo' => 'bar'
          }
        }
      end

      it 'should return the existing object' do
        expect(subject.metadata).to eq({ 'foo' => 'bar' })
      end
    end

    context 'when there is no metadata yet' do
      it 'should return an empty metadata object' do
        expect(subject.metadata).to eq({})
      end
    end
  end

  describe '#metadata=' do
    let(:metadata) do
      { 'foo' => 'bar', 'baz' => 'bam' }
    end

    it 'should set the key value pairs' do
      subject.metadata = metadata
      expect(subject.metadata).to eq(metadata)
    end

    it 'should not replace the underlying object' do
      expect { subject.metadata = metadata }.to_not change(subject, :object_id)
    end
  end
end
