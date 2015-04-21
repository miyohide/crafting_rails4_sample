require "mongoid"
require "mongo_metrics/engine"
require "active_support/notifications"

module MongoMetrics
  EVENT = "process_action.action_controller"
  ActiveSupport::Notifications.subscribe EVENT do |*args|
    MongoMetrics::Metric.store!(args)
  end
end
