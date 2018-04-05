describe Interactor::Initializer::Initialize do
  describe '.for' do
    let(:target_class) { Class.new }
    let(:expected_values) { { test1: 1, test2: Class.new } }

    shared_examples 'object initializer' do
      it 'assigns variables' do
        subject

        expected_values.each do |name, value|
          expect(interactor.instance_variable_get("@#{name}")).to eq(value)
        end
      end
    end

    context 'when regular params' do
      subject { described_class.for(target_class, attributes, defaults) }

      it_behaves_like 'object initializer' do
        let(:interactor) { target_class.new(expected_values[:test1], expected_values[:test2]) }
        let(:attributes) { [:test1, :test2] }
        let(:defaults) { {} }
      end

      context 'with default values' do
        it_behaves_like 'object initializer' do
          let(:interactor) { target_class.new(expected_values[:test1]) }
          let(:attributes) { [:test1] }
          let(:defaults) { { test2: expected_values[:test2] } }
        end

        it_behaves_like 'object initializer' do
          let(:interactor) { target_class.new(expected_values[:test1], expected_values[:test2]) }
          let(:attributes) { [:test1] }
          let(:defaults) { { test2: 'default' } }
        end
      end

      context 'when default values only' do
        it_behaves_like 'object initializer' do
          let(:interactor) { target_class.new }
          let(:attributes) { [] }
          let(:defaults) { expected_values }
        end
      end
    end

    context 'when keyword params' do
      subject { described_class.for(target_class, attributes, defaults, keyword_params: true) }

      it_behaves_like 'object initializer' do
        let(:interactor) { target_class.new(expected_values) }
        let(:attributes) { [:test1, :test2] }
        let(:defaults) { {} }
      end

      context 'with default values' do
        it_behaves_like 'object initializer' do
          let(:interactor) { target_class.new(test1: expected_values[:test1]) }
          let(:attributes) { [:test1] }
          let(:defaults) { { test2: expected_values[:test2] } }
        end

        it_behaves_like 'object initializer' do
          let(:interactor) do
            target_class.new(test1: expected_values[:test1], test2: expected_values[:test2])
          end
          let(:attributes) { [:test1] }
          let(:defaults) { { test2: 'default' } }
        end
      end

      context 'with default values only' do
        it_behaves_like 'object initializer' do
          let(:interactor) { target_class.new }
          let(:attributes) { [] }
          let(:defaults) { expected_values }
        end
      end
    end
  end
end
