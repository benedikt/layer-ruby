
require 'spec_helper'

describe Layer::Announcement do

  let(:client) { instance_double('Layer::Client') }
  let(:response) do
    {
      'url' => 'https://api.layer.com/apps/default_app_id/announcements/announcement_id',
      'sent_at' => '2015-06-19T11:00:00Z',
      'id' => 'layer:///announcements/announcement_id',
      'recipients' => [
        '1',
        '2'
      ],
      'sender' => {
        'name'=>'test'
      },
      'parts' => [
        {
          'mime_type' => 'text/plain',
          'body' => 'Hello'
        }
      ]
    }
  end

  subject { described_class.from_response(response, client) }

  describe '#sent_at' do
    it 'should return the time the announcement was sent at' do
      expect(subject.sent_at).to eq(Time.utc(2015, 06, 19, 11, 0, 0))
    end
  end

  describe '.create' do
    let(:attributes) do
      {
        'recipients' => ['1', '2'],
        'sender' => {
          'name'=>'test'
        },
        'parts' => [
          {
            'mime_type' => 'text/plain',
            'body' => 'Hello'
          }
        ]
      }
    end

    before do
      allow(client).to receive(:post).and_return(response)
    end

    it 'should create the announcement' do
      described_class.create(attributes, client)
      expect(client).to have_received(:post).with('/announcements', attributes)
    end

    it 'should return an instace' do
      expect(described_class.create(attributes, client))
        .to be_kind_of(described_class)
    end
  end

end
