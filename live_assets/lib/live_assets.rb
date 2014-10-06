require "live_assets/engine"
require "thread"
require "listen"

module LiveAssets
   mattr_reader :subscribers
   @@subscribers = []

   def self.subscribe(subscriber)
      subscribers << subscriber
   end

   def self.unsubscribe(subscriber)
      subscribers.delete(subscriber)
   end

   def self.start_listener(event, directories)
      Thread.new do
         listener = Listen.to(*directories, latency: 0.5) do |_modified, _added, _removed|
            subscribers.each { |s| s << event }
         end

         listener.start
      end
   end
end

