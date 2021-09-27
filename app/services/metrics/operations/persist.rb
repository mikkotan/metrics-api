module Metrics
  module Operations
    class Persist
      include App::Operation

      def call(metric_record: nil, params:)
        metric = metric_record || Metric.new
        metric.assign_attributes(params)
        metric.save!

        Success(metric)
      rescue ActiveRecord::StatementInvalid
        Failure(:statement_invalid)
      end
    end
  end
end
