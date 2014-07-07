require "action_view/template"
ActionView::Template.register_template_handler :rb, lambda { |template| template.source }
ActionView::Template.register_template_handler :string, lambda { |template| "%Q{#{template.source}}" }

module Handlers
end

