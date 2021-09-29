module Metrics
  module Transactions
    class List
      include App::Transaction

      def initialize(deps = {})
        @metric_klass = deps[:metric_klass] || Metric
      end

      def call()
        metrics = @metric_klass.all.order('created_at DESC')
        Success(metrics)
      end
    end
  end
end
