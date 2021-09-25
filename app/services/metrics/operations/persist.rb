module Metrics
  module Operations
    class Persist
      include App::Operation

      def call(metric_record: nil, params:)
        metric = metric_record || Metric.new

        metric.name = params[:name]
        metric.save!

        Success(metric)
      rescue ActiveRecord::RecordInvalid
        Failure([:invalid_record, metric.errors.full_messages])
      end
    end
  end
end
