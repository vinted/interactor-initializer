# frozen_string_literal: true

class Interactor::Initializer::Helper
  def self.modify_class(target_class, signature, attributes, class_methods)
    assignments = attr_assignments(attributes)

    target_class.class_eval <<-RUBY, __FILE__, __LINE__ + 1
      def initialize(#{signature})
        #{assignments}
      end

      #{class_methods}
    RUBY

    attr_readers(target_class, attributes)
  end

  def self.attr_readers(target_class, attributes)
    target_class.class_eval do
      attributes.each do |attr|
        attr_reader(attr)
        protected(attr)
      end
    end
  end

  def self.methods_with_params(params = [])
    params_signature = params.join(',')

    <<-RUBY
      def self.for(#{params_signature})
        new(#{params_signature}).run
      end

      def self.run(#{params_signature})
        new(#{params_signature}).run
      end

      def self.with(#{params_signature})
        new(#{params_signature}).run
      end
    RUBY
  end

  def self.methods_with_keywords(attributes)
    method_params = attributes.map { |attr| "#{attr}:" }.join(', ')
    initializer_params = attributes.map { |attr| "#{attr}: #{attr}" }.join(', ')

    <<-RUBY
      def self.for(#{method_params})
        new(#{initializer_params}).run
      end

      def self.run(#{method_params})
        new(#{initializer_params}).run
      end

      def self.with(#{method_params})
        new(#{initializer_params}).run
      end
    RUBY
  end

  def self.attr_assignments(attributes)
    attributes.map { |attr| "@#{attr} = #{attr}" }.join(';')
  end
end
