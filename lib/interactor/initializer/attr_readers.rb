class Interactor::Initializer::AttrReaders
  def self.for(target_class, attributes, defaults)
    target_class.class_eval do
      (attributes + defaults.keys).each do |attribute|
        attr_reader(attribute)
        protected(attribute)
      end
    end
  end
end
