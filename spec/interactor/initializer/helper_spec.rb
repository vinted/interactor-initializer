# frozen_string_literal: true

describe Interactor::Initializer::Helper do
  describe '.attr_readers' do
    subject { described_class.attr_readers(dummy_class, attributes) }

    let(:dummy_class) { Class.new }
    let(:attributes) { %i[test1 test2] }

    it 'adds protected attr_reader' do
      subject
      expect(dummy_class.protected_method_defined?(:test1)).to be_truthy
      expect(dummy_class.protected_method_defined?(:test2)).to be_truthy
    end
  end
end
