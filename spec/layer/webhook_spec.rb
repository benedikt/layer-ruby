require 'spec_helper'

describe Layer::Webhook do

  let(:client) { instance_double('Layer::Client') }
  let(:response) do
    {
      'id' => 'layer:///apps/default_app_id/webhooks/webhook_id',
      'url' => 'https://api.layer.com/default_app_id/webhooks/webhook_id',
      'target_url' => 'https://client.example.com/layeruser/foo',
      'event_types' => [
        'user.registered',
        'conversation.created'
      ],
      'status' => 'unverified',
      'created_at' => '2015-06-19T11:00:00Z',
      'target_config' => {
        'key1' => 'value1',
        'key2' => 'value2'
      }
    }
  end

  subject { described_class.from_response(response, client) }

  describe '#created_at' do
    it 'should return the time the webhook was created at' do
      expect(subject.created_at).to eq(Time.utc(2015, 06, 19, 11, 0, 0))
    end
  end

  describe '#activate!' do
    it 'should activate the webhook' do
      expect(client).to receive(:post).with(subject.url + '/activate')
      subject.activate!
    end
  end

  describe '#deactivate!' do
    it 'should deactivate the webhook' do
      expect(client).to receive(:post).with(subject.url + '/deactivate')
      subject.deactivate!
    end
  end

  context 'when status is unverified' do
    before { response['status'] = 'unverified' }

    it { should be_unverified }
    it { should_not be_active }
    it { should_not be_inactive }
  end

  context 'when status is active' do
    before { response['status'] = 'active' }

    it { should_not be_unverified }
    it { should be_active }
    it { should_not be_inactive }
  end

  context 'when status is inactive' do
    before { response['status'] = 'inactive' }

    it { should_not be_unverified }
    it { should_not be_active }
    it { should be_inactive }
  end

end
