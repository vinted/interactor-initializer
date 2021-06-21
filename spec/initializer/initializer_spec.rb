describe Interactor::Initializer do
  let(:interactor) do
    Class.new do
      include Interactor::Initializer

      def run
        :result
      end
    end
  end

  describe '.for' do
    subject { interactor.for }

    it { is_expected.to eq(:result) }
  end

  describe '.with' do
    subject { interactor.with }

    it { is_expected.to eq(:result) }
  end

  describe '.run' do
    subject { interactor.run }

    it { is_expected.to eq(:result) }
  end
end
