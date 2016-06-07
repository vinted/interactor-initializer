require 'interactor/initializer/version'

module Interactor
  module Initializer
    def self.included(target_class)
      target_class.extend ClassMethods
      Interactor::Initializer::CallMethods.for(target_class)
    end

    module ClassMethods
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
