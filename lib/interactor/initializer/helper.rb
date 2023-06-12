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

  def self.methods_with_params(attributes = [])
    signature = attributes.join(', ')
    initializer_params = signature

    <<-RUBY
      def self.for(#{signature})
        new(#{initializer_params}).run
      end

      def self.run(#{signature})
        new(#{initializer_params}).run
      end

      def self.with(#{signature})
        new(#{initializer_params}).run
      end
    RUBY
  end

  def self.methods_with_keywords(attributes)
    signature = attributes.map { |attr| "#{attr}:" }.join(', ')
    initializer_params = attributes.map { |attr| "#{attr}: #{attr}" }.join(', ')

    <<-RUBY
      def self.for(#{signature})
        new(#{initializer_params}).run
      end

      def self.run(#{signature})
        new(#{initializer_params}).run
      end

      def self.with(#{signature})
        new(#{initializer_params}).run
      end
    RUBY
  end

  def self.attr_assignments(attributes)
    attributes.map { |attr| "@#{attr} = #{attr}" }.join(';')
  end
end
