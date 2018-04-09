describe Interactor::Initializer::AttrReaders do
  describe '.for' do
    subject { described_class.for(dummy_class, attributes, defaults) }
    let(:dummy_class) { Class.new }
    let(:attributes) { [:test1, :test2] }
    let(:defaults) { { test3: 3 } }

    it 'adds protected attr_reader' do
      subject
      expect(dummy_class.protected_method_defined?(:test1)).to be_truthy
      expect(dummy_class.protected_method_defined?(:test2)).to be_truthy
      expect(dummy_class.protected_method_defined?(:test3)).to be_truthy
    end
  end
end
