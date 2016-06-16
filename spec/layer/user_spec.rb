require 'spec_helper'

describe Layer::User do

  let(:client) { instance_double("Layer::Client") }

  describe '.find' do
    it 'should instantiate a new user resource' do
      user = described_class.find('1')
      expect(user).to be_kind_of(described_class)
    end

    it 'should not call the API' do
      expect(client).to_not receive(:get)
      described_class.find('1')
    end
  end

  subject { described_class.find(1, client) }

  describe '#blocks' do
    it 'should return an relation proxy' do
      expect(subject.blocks).to be_kind_of(Layer::RelationProxy)
    end

    it 'should have Block as resource_type' do
      expect(subject.blocks.resource_type).to eq(Layer::Block)
    end

    it 'should support the create operation' do
      expect(subject.blocks).to be_kind_of(Layer::Operations::Create::ClassMethods)
    end

    it 'should support the list operation' do
      expect(subject.blocks).to be_kind_of(Layer::Operations::List::ClassMethods)
    end

    it 'should support the delete operation' do
      expect(subject.blocks).to be_kind_of(Layer::Operations::Delete::ClassMethods)
    end

    describe '#from_response' do
      it 'should fake the url attribute' do
        block = subject.blocks.from_response({ 'user_id' => '2' }, client)
        expect(block.url).to eq('/users/1/blocks/2')
      end
    end

    describe '#create' do
      before do
        allow(client).to receive(:post).and_return(nil)
      end

      it 'should fake the block resource' do
        block = subject.blocks.create({ 'user_id' => '2' }, client)
        expect(block).to be_instance_of(Layer::Block)
      end

      it 'should create the block via the API' do
        subject.blocks.create({ 'user_id' => '2' }, client)
        expect(client).to have_received(:post).with('/users/1/blocks', { 'user_id' => '2' })
      end
    end

    describe '#all' do
      before do
        allow(client).to receive(:get).and_return([{ 'user_id' => '2' }])
      end

      it 'should return a collection of blocks' do
        expect(subject.blocks.all.map(&:class)).to eq([Layer::Block])
      end

      it 'should fetch the blocks from via the API' do
        subject.blocks.all
        expect(client).to have_received(:get).with('/users/1/blocks')
      end
    end

    describe '#delete' do
      before do
        allow(client).to receive(:delete).and_return(nil)
      end

      it 'should delete the block via the API' do
        subject.blocks.delete(2)
        expect(client).to have_received(:delete).with('/users/1/blocks/2')
      end
    end

  end

  describe '#identity' do
    it 'should return an relation proxy' do
      expect(subject.identity).to be_kind_of(Layer::RelationProxy)
    end

    it 'should have Identity as resource_type' do
      expect(subject.identity.resource_type).to eq(Layer::Identity)
    end

    it 'should support the create operation' do
      expect(subject.identity).to be_kind_of(Layer::Operations::Create::ClassMethods)
    end

    describe '#create' do
      before do
        allow(client).to receive(:post).and_return(nil)
      end

      it 'should fake the identity resource' do
        identity = subject.identity.create({ 'first_name' => 'Frodo' }, client)
        expect(identity).to be_instance_of(Layer::Identity)
      end

      it 'should create the identity via the API' do
        identity = subject.identity.create({ 'first_name' => 'Frodo' }, client)
        expect(client).to have_received(:post).with('/users/1/identity', { 'first_name' => 'Frodo' })
      end
    end

    describe '#get' do
      before do
        allow(client).to receive(:get).and_return({ 'first_name' => 'Frodo', 'last_name' => 'Baggins' })
      end

      it 'should return a Identity' do
        expect(subject.identity.get.class).to eq(Layer::Identity)
      end

      it 'should fetch the identity from via the API' do
        subject.identity.get
        expect(client).to have_received(:get).with('/users/1/identity')
      end
    end

    describe '#delete' do
      before do
        allow(client).to receive(:delete).and_return(nil)
      end

      it 'should delete the identity via the API' do
        subject.identity.delete
        expect(client).to have_received(:delete).with('/users/1/identity')
      end
    end

  end

  describe '#conversations' do
    it 'should return an relation proxy' do
      expect(subject.conversations).to be_kind_of(Layer::RelationProxy)
    end

    it 'should have Message as resource_type' do
      expect(subject.conversations.resource_type).to eq(Layer::Conversation)
    end

    it 'should support the find operation' do
      expect(subject.conversations).to be_kind_of(Layer::Operations::Find::ClassMethods)
    end

    it 'should support the list operation' do
      expect(subject.conversations).to be_kind_of(Layer::Operations::List::ClassMethods)
    end
  end

  describe '#messages' do
    it 'should return an relation proxy' do
      expect(subject.messages).to be_kind_of(Layer::RelationProxy)
    end

    it 'should have Message as resource_type' do
      expect(subject.messages.resource_type).to eq(Layer::Message)
    end

    it 'should support the find operation' do
      expect(subject.messages).to be_kind_of(Layer::Operations::Find::ClassMethods)
    end
  end


end
