class Interactor::Initializer::CallMethods
  METHOD_NAMES = %i(for with run).freeze

  def self.for(target_class)
    METHOD_NAMES.each do |method_name|
      target_class.define_singleton_method(method_name) { |*args| new(*args).run }
    end
  end
end
