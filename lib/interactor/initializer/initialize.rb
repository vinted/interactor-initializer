class Interactor::Initializer::Initialize
  # Keep in sync with Interactor::Initializer::ClassMethods
  API_METHODS = %i[for run with]

  def self.for(*args, **kwargs)
    new(*args, **kwargs).run
  end

  attr_reader :target_class, :attributes, :keyword_params

  def initialize(target_class, attributes, keyword_params: false)
    @target_class = target_class
    @attributes = attributes
    @keyword_params = keyword_params
  end

  def run
    define_public_api
    define_initializer
  end

  private

  def define_public_api
    method_definitions = API_METHODS.map do |method_name|
      <<-RUBY
        def self.#{method_name}(#{initializer_signature(attributes)})
          new(#{forwarded_attributes(attributes)}).run
        end
      RUBY
    end.join("\n")

    target_class.class_eval(method_definitions)
  end

  def define_initializer
    target_class.class_eval <<-RUBY
      def initialize(#{initializer_signature(attributes)})
        #{attr_assignments(attributes)}
      end
    RUBY
  end

  def forwarded_attributes(attributes)
    if keyword_params
      attributes.map { |attribute| "#{attribute}: #{attribute}" }.join(', ')
    else
      attributes.join(', ')
    end
  end

  def initializer_signature(attributes)
    if keyword_params
      attributes.map { |attribute| "#{attribute}:" }.join(', ')
    else
      attributes.join(', ')
    end
  end

  def attr_assignments(attributes)
    attributes.map { |attribute| "@#{attribute} = #{attribute};" }.join
  end
end
