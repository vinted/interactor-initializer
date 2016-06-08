describe Interactor::Initializer::AttrReaders do
  describe '.for' do
    subject { described_class.for(dummy_class, attributes) }
    let(:dummy_class) { Class.new }
    let(:attributes) { [:test1, :test2] }

    it 'adds attr_reader' do
      subject
      expect(dummy_class.new).to respond_to :test1
      expect(dummy_class.new).to respond_to :test2
    end
  end
end
