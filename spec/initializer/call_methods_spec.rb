describe Interactor::Initializer::CallMethods do
  describe '.for' do
    subject { described_class.for(dummy_class) }
    let(:dummy_class) { Class.new }

    it 'adds .for .with and .run class methods' do
      subject
      expect(dummy_class).to respond_to :for
      expect(dummy_class).to respond_to :with
      expect(dummy_class).to respond_to :run
    end
  end
end
