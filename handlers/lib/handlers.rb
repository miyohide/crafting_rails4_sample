require "action_view/template"
require "rdiscount"

ActionView::Template.register_template_handler :rb, lambda { |template| template.source }
ActionView::Template.register_template_handler :string, lambda { |template| "%Q{#{template.source}}" }
ActionView::Template.register_template_handler :md, lambda { |template| "RDiscount.new(#{template.source.inspect}).to_html" }

module Handlers
   module MERB
      def self.erb_handler
         @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
      end

      def self.call(template)
         compiled_source = erb_handler.call(template)
         "RDiscount.new(begin; #{compiled_source}; end).to_html"
      end
   end
end

ActionView::Template.register_template_handler :merb, Handlers::MERB

