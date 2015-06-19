require 'spec_helper'

describe Layer::Block do

  let(:client) { instance_double("Layer::Client") }
  let(:response) do
    {
      'user_id' => '2',
      'url' => '/users/1/blocks/2'
    }
  end

  subject { described_class.from_response(response, client) }

  describe '.delete' do
    it 'should delete the block via the API' do
      expect(client).to receive(:delete).with('/users/1/blocks/2')
      subject.delete
    end
  end
end
