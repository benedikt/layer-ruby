require 'spec_helper'

describe Layer::Content do

  let(:file) { instance_double("File", size: 1234) }

  let(:client) { instance_double('Layer::Client') }
  let(:response) do
    {
      'id' => 'layer:///content/content-id',
      'size' => 1461750,
      'download_url' => 'https://example.com/download',
      'refresh_url' => 'https://api.layer.com/content/content-id',
      'expiration' => '2015-10-06T13:35:13.000Z',
      'upload_url' => nil
    }
  end

  subject { described_class.from_response(response, client) }

  describe '.create' do
    before do
      allow_any_instance_of(described_class).to receive(:upload)
      allow(client).to receive(:post).and_return({
        'id' => 'layer:///content/content-id',
        'download_url' => nil,
        'refresh_url' => nil,
        'expiration' => '2015-10-06T13:35:13.000Z',
        'upload_url' => 'https://example.com/upload'
      })
    end

    it 'should create a new content resource on the server' do
      described_class.create('image/jpeg', file, client)

      expect(client).to have_received(:post).with('/content', {}, {
        'Upload-Content-Type' => 'image/jpeg',
        'Upload-Content-Length' => file.size
      })
    end

    it 'should upload the given file' do
      expect_any_instance_of(described_class).to receive(:upload).with(file)
      described_class.create('image/jpeg', file, client)
    end

    it 'should fake the size in the created resource' do
      resource = described_class.create('image/jpeg', file, client)
      expect(resource.size).to eq(file.size)
    end
  end

  describe '.url' do
    it 'should return /content' do
      expect(described_class.url).to eq('/content')
    end
  end

  describe '#to_json' do
    it 'should return the id and the size' do
      expect(subject.to_json).to eq({ id: subject.id, size: subject.size }.to_json)
    end
  end

  describe '#url' do
    context 'when there is a refresh_url' do
      it 'should return the refresh_url' do
        expect(subject.url).to eq(subject.refresh_url)
      end
    end

    context 'when there is not a refresh url' do
      before do
        response['refresh_url'] = nil
      end

      it 'should build a proper url' do
        expect(subject.url).to eq('/content/content-id')
      end
    end
  end

  describe '#upload' do
    let(:upload_url) { 'https://example.com/upload' }

    before do
      response['upload_url'] = upload_url
    end

    it 'should upload the given file' do
      expect(RestClient).to receive(:put).with(upload_url, file)
      subject.upload(file)
    end
  end

end
