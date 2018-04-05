require 'interactor/initializer/version'
require 'interactor/initializer/attr_readers'
require 'interactor/initializer/call_methods'
require 'interactor/initializer/initialize'

module Interactor
  module Initializer
    def self.included(target_class)
      target_class.extend ClassMethods
      Interactor::Initializer::CallMethods.for(target_class)
    end

    module ClassMethods
      module_function

      def initialize_with(*attributes, **defaults)
        Interactor::Initializer::Initialize.for(self, attributes, defaults)
        Interactor::Initializer::AttrReaders.for(self, attributes, defaults)
      end

      def initialize_with_keyword_params(*attributes, **defaults)
        Interactor::Initializer::Initialize.for(self, attributes, defaults, keyword_params: true)
        Interactor::Initializer::AttrReaders.for(self, attributes, defaults)
      end
    end
  end
end
