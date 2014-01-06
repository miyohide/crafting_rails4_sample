module MailForm
   class Base
      include ActiveModel::Conversion
      include ActiveModel::AttributeMethods
      extend ActiveModel::Naming

      attribute_method_prefix 'clear_'

      attribute_method_suffix '?'

      def self.attributes(*names)
         attr_accessor(*names)

         define_attribute_methods(names)
      end

      def to_model
         self
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
