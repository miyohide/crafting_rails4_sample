Rails.application.routes.draw do

  mount MongoMetrics::Engine => "/mongo_metrics"
end
