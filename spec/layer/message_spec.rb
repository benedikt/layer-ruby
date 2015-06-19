require 'spec_helper'

describe Layer::Message do

  let(:client) { instance_double("Layer::Client") }
  let(:response) do
    {
      "conversation" => {
        "id" => "layer:///conversations/conversation_id",
        "url" => "https://api.layer.com/apps/default_app_id/conversations/conversation_id"
      },
      "url" => "https://api.layer.com/apps/default_app_id/conversations/conversation_id/messages/message_id",
      "sent_at" => "2015-06-19T11:00:00Z",
      "id" => "layer:///messages/message_id",
      "recipient_status" => {
        "1" => "sent",
        "2" => "sent"
      },
      "sender" => {
        "name"=>"test"
      },
      "parts" => [
        {
          "mime_type" => "text/plain",
          "body" => "Hello"
        }
      ]
    }
  end

  subject { described_class.from_response(response, client) }

  describe '#conversation' do
    it 'should return the conversation this message belongs to' do
      expect(subject.conversation).to be_kind_of(Layer::Conversation)
    end
  end

  describe '#sent_at' do
    it 'should return the time the message was sent at' do
      expect(subject.sent_at).to eq(Time.utc(2015, 06, 19, 11, 0, 0))
    end
  end

end
