# frozen_string_literal: true

describe Interactor::Initializer do
  let(:interactor) do
    Class.new do
      include Interactor::Initializer

      initialize_with :arg1, :arg2

      def run
        :result
      end
    end
  end
  let(:params) { %w[value1 value2] }

  describe '.for' do
    subject { interactor.for(*params) }

    it { is_expected.to eq(:result) }
  end

  describe '.with' do
    subject { interactor.with(*params) }

    it { is_expected.to eq(:result) }
  end

  describe '.run' do
    subject { interactor.run(*params) }

    it { is_expected.to eq(:result) }
  end

  describe '.new' do
    subject { interactor.new(*params) }

    it 'adds instance variables' do
      expect(subject.instance_variable_get(:@arg1)).to eq 'value1'
      expect(subject.instance_variable_get(:@arg2)).to eq 'value2'
    end
  end

  context 'when incorrect number of params' do
    subject { interactor.for(*params) }

    let(:params) { %w[value1] }

    it 'raises an error' do
      expect { subject }.to raise_error(/wrong number of arguments/)
    end
  end

  context 'when initialization with keywords' do
    let(:interactor) do
      Class.new do
        include Interactor::Initializer

        initialize_with_keyword_params :arg1, :arg2

        def run
          :result
        end
      end
    end
    let(:params) do
      { arg1: 'value1', arg2: 'value2' }
    end

    describe '.for' do
      subject { interactor.for(params) }

      it { is_expected.to eq(:result) }
    end

    describe '.with' do
      subject { interactor.with(params) }

      it { is_expected.to eq(:result) }
    end

    describe '.run' do
      subject { interactor.run(params) }

      it { is_expected.to eq(:result) }
    end

    describe '.new' do
      subject { interactor.new(**params) }

      it 'adds instance variables' do
        expect(subject.instance_variable_get(:@arg1)).to eq 'value1'
        expect(subject.instance_variable_get(:@arg2)).to eq 'value2'
      end
    end

    context 'when incorrect keywords' do
      subject { interactor.for(params) }

      let(:params) do
        { arg1: 'value2', arg4: 'value2' }
      end

      it 'raises an error' do
        expect { subject }.to raise_error(/missing keyword: :arg2/)
      end
    end
  end
end
