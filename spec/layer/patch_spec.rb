require 'spec_helper'

describe Layer::Patch do

  subject { Layer::Patch.new }

  describe '#add' do
    it 'should format the operation correctly' do
      subject.add('property', 'value')

      expect(subject.operations.last).to eq({
        operation: 'add',
        property: 'property',
        value: 'value'
      })
    end
  end

  describe '#add_index' do
    it 'should format the operation correctly' do
      subject.add_index('property', 0, 'value')

      expect(subject.operations.last).to eq({
        operation: 'add',
        property: 'property',
        index: 0,
        value: 'value'
      })
    end
  end

  describe '#remove' do
    it 'should format the operation correctly' do
      subject.remove('property', 'value')

      expect(subject.operations.last).to eq({
        operation: 'remove',
        property: 'property',
        value: 'value'
      })
    end
  end

  describe '#remove_index' do
    it 'should format the operation correctly' do
      subject.remove_index('property', 0)

      expect(subject.operations.last).to eq({
        operation: 'remove',
        property: 'property',
        index: 0
      })
    end
  end

  describe '#set' do
    it 'should format the operation correctly' do
      subject.set('property', 'value')

      expect(subject.operations.last).to eq({
        operation: 'set',
        property: 'property',
        value: 'value'
      })
    end
  end

  describe '#replace' do
    it 'should format the operation correctly' do
      subject.replace('property', 'value')

      expect(subject.operations.last).to eq({
        operation: 'replace',
        property: 'property',
        value: 'value'
      })
    end
  end

  describe '#delete' do
    it 'should format the operation correctly' do
      subject.delete('property')

      expect(subject.operations.last).to eq({
        operation: 'delete',
        property: 'property'
      })
    end
  end

  describe '#nested' do
    it 'should return a new nested instance' do
      nested = subject.nested('parent')
      nested.add('property', 'value')
      expect(subject.operations.last).to eq({
        operation: 'add',
        property: 'parent.property',
        value: 'value'
      })
    end

    it 'should not loose the reference to the operations array' do
      nested = subject.nested('parent')
      nested.operations
      subject.reset
      expect(nested.operations).to be(subject.operations)
    end
  end

end
