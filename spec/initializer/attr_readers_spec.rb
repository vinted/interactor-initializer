describe Interactor::Initializer::AttrReaders do
  describe '.for' do
    subject { described_class.for(dummy_class, attributes) }
    let(:dummy_class) { Class.new }
    let(:attributes) { [:test1, :test2] }

    it 'adds private attr_reader' do
      subject
      expect(dummy_class.private_method_defined?(:test1)).to be_truthy
      expect(dummy_class.private_method_defined?(:test2)).to be_truthy
    end
  end
end
