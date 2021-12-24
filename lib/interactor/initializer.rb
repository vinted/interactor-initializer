require 'interactor/initializer/version'
require 'interactor/initializer/attr_readers'
require 'interactor/initializer/initialize'

module Interactor
  module Initializer
    def self.included(target_class)
      target_class.extend ClassMethods
    end

    # Default implementation to make IDEs happy
    # Will be overridden by Interactor::Initializer::Initialize
    def initialize(*unknown_args); end

    module ClassMethods
      # Default implementation
      def for(*unknown_args)
        new(*unknown_args).run
      end

      def with(*unknown_args)
        new(*unknown_args).run
      end

      def run(*unknown_args)
        new(*unknown_args).run
      end

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
