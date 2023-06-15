# frozen_string_literal: true

require 'interactor/initializer/version'
require 'interactor/initializer/helper'

module Interactor
  module Initializer
    def self.included(target_class)
      target_class.extend ClassMethods

      class_methods = Interactor::Initializer::Helper.methods_with_params
      Interactor::Initializer::Helper.modify_class(target_class, '', [], class_methods)
    end

    module ClassMethods
      module_function

      def initialize_with(*attributes)
        signature = attributes.join(', ')
        class_methods = Interactor::Initializer::Helper.methods_with_params(attributes)

        Interactor::Initializer::Helper.modify_class(self, signature, attributes, class_methods)
      end

      def initialize_with_keyword_params(*attributes)
        signature = attributes.map { |attr| "#{attr}:" }.join(', ')
        class_methods = Interactor::Initializer::Helper.methods_with_keywords

        Interactor::Initializer::Helper.modify_class(self, signature, attributes, class_methods)
      end
    end
  end
end
