require 'interactor/initializer/version'
require 'interactor/initializer/attr_readers'
require 'interactor/initializer/initialize'

module Interactor
  module Initializer
    def self.included(target_class)
      target_class.extend ClassMethods
    end

    module ClassMethods
      def for(*args)
        new(*args).run
      end

      def with(*args)
        new(*args).run
      end

      def run(*args)
        new(*args).run
      end

      module_function

      def initialize_with(*attributes)
        Interactor::Initializer::Initialize.for(self, attributes)
        Interactor::Initializer::AttrReaders.for(self, attributes)
      end

      def initialize_with_keyword_params(*attributes)
        Interactor::Initializer::Initialize.for(self, attributes, keyword_params: true)
        Interactor::Initializer::AttrReaders.for(self, attributes)
      end
    end
  end
end
