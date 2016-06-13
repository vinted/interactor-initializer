class Interactor::Initializer::AttrReaders
  def self.for(target_class, attributes)
    target_class.class_eval do
      attributes.each do |attribute|
        attr_reader(attribute)
        protected(attribute)
      end
    end
  end
end
