module MailForm
   class Base
      include ActiveModel::Conversion
      include ActiveModel::AttributeMethods
      extend ActiveModel::Naming
      extend ActiveModel::Translation
      include ActiveModel::Validations
      include MailForm::Validators
      extend ActiveModel::Callbacks

      attribute_method_prefix 'clear_'

      attribute_method_suffix '?'

      define_model_callbacks :deliver

      class_attribute :attribute_names
      self.attribute_names = []

      def initialize(attributes = {})
         attributes.each do |attr, value|
            self.public_send("#{attr}=", value)
         end if attributes
      end

      def self.attributes(*names)
         attr_accessor(*names)

         define_attribute_methods(names)
      end

      def to_model
         self
      end

      def persisted?
         false
      end

      def deliver
         if valid?
            run_callbacks(:deliver) do
               MailForm::Notifier.contact(self).deliver
            end
         else
            false
         end
      end

      def self.attributes(*names)
         attr_accessor(*names)
         define_attribute_methods(names)

         self.attribute_names += names
      end

      protected
      def clear_attribute(attribute)
         send("#{attribute}=", nil)
      end

      def attribute?(attribute)
         send(attribute).present?
      end
   end
end
