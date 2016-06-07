class Interactor::Initializer::AttrReaders
  def self.for(target_class, attributes)
    target_class.class_eval { attr_reader(*attributes) }
  end
end
