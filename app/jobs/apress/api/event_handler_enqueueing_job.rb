module Apress
  module Api
    class EventHandlerEnqueueingJob
      include Resque::Integration

      queue :api_callbacks

      def self.perform(handler, event_params)
        job = handler.camelize.constantize

        if job.respond_to?(:enqueue)
          job.enqueue(event_params)
        else
          Resque.enqueue(job, event_params)
        end
      end
    end
  end
end
