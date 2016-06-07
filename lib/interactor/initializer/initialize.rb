class Interactor::Initializer::Initialize
  def self.for(*args)
    new(*args).run
  end

  attr_reader :target_class, :attributes, :keyword_params

  def initialize(target_class, attributes, keyword_params: false)
    @target_class = target_class
    @attributes = attributes
    @keyword_params = keyword_params
  end

  def run
    target_class.class_eval <<-RUBY
      def initialize(#{initializer_signature(attributes)})
        #{attr_assignments(attributes)}
      end
    RUBY
  end

  private

  def initializer_signature(attributes)
    return attributes.join(', ') unless keyword_params

    attributes.map { |attribute| "#{attribute}:" }.join(', ')
  end

  def attr_assignments(attributes)
    attributes.inject('') do |assignments, attribute|
      "#{assignments}@#{attribute} = #{attribute};"
    end
  end
end
