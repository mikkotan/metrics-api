module Metrics
  module Transactions
    class List
      include App::Transaction

      def initialize(deps = {})
        @metric_klass = deps[:metric_klass] || Metric
      end

      def call()
        metrics = @metric_klass.all
        Success(metrics)
      end
    end
  end
end
