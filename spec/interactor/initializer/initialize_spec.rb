describe Interactor::Initializer::Initialize do
  describe '.for' do
    subject { described_class.for(dummy_class, attributes, keyword_params: keyword_params) }
    let(:dummy_class) { Class.new }
    let(:attributes) { [:test1, :test2] }
    let(:keyword_params) { false }

    shared_examples 'object initializer' do
      it 'adds object initializer' do
        subject
        expect(dummy_instance.instance_variable_get(:@test1)).to eq 1
        expect(dummy_instance.instance_variable_get(:@test2)).to eq 2
      end
    end

    it_behaves_like 'object initializer' do
      let(:dummy_instance) { dummy_class.new(1, 2) }
    end

    context 'when keyword params' do
      let(:keyword_params) { true }

      it_behaves_like 'object initializer' do
        let(:dummy_instance) { dummy_class.new(test1: 1, test2: 2) }
      end
    end
  end
end
