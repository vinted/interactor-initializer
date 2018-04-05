class Interactor::Initializer::Initialize
  def self.for(*args)
    new(*args).run
  end

  attr_reader :target_class, :attributes, :defaults, :keyword_params

  def initialize(target_class, attributes, defaults, keyword_params: false)
    @target_class = target_class
    @attributes = attributes
    @defaults = defaults
    @keyword_params = keyword_params
  end

  def run
    define_initializer
    define_defaults_initializer
  end

  private

  def define_initializer
    target_class.class_eval <<-RUBY
      def initialize(#{initializer_signature})
        #{attr_assignments}
        initialize_defaults
      end
    RUBY
  end

  def define_defaults_initializer
    target_class.class_exec(defaults) do |defaults|
      define_method :initialize_defaults do
        defaults.keys.each do |name|
          instance_variable_set("@#{name}", defaults[name]) unless instance_variable_get("@#{name}")
        end
      end
    end
  end

  def initializer_signature
    keyword_params ? keyword_signature : regular_signature
  end

  def keyword_signature
    keyword_params = attributes.map { |attribute| "#{attribute}:" }
    default_params = defaults.keys.map { |key| "#{key}: nil" }
    (keyword_params + default_params).join(', ')
  end

  def regular_signature
    default_attributes = defaults.keys.map { |key| "#{key} = nil" }
    (attributes + default_attributes).join(', ')
  end

  def attr_assignments
    (defaults.keys + attributes).map { |attribute| "@#{attribute} = #{attribute}" }.join(';')
  end
end
