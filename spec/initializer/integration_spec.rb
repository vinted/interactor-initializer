RSpec.describe 'integration' do
  class MyInteractor
    include Interactor::Initializer
    initialize_with :foo, :bar

    def run
      [foo, bar]
    end
  end

  class MyKeywordInteractor
    include Interactor::Initializer
    initialize_with_keyword_params :foo, :bar

    def run
      [foo, bar]
    end
  end

  it 'works end to end' do
    expect(MyInteractor.run(1, 2)).to eq([1, 2])
    expect(MyKeywordInteractor.run(foo: 1, bar: 2)).to eq([1, 2])
    args = { foo: 1, bar: 2 }
    expect(MyKeywordInteractor.run(args)).to eq([1, 2]) # triggers warning
    expect(MyKeywordInteractor.run(**args)).to eq([1, 2])
  end
end
