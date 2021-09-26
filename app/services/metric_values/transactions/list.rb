module MetricValues
  module Transactions
    class List
      include App::Transaction

      def initialize(deps = {})
        contract = deps[:contract] || Contracts::List.new
        @apply_contract = deps[:apply_contract] || App::ApplyContract.new(contract)
        @validate_metric = deps[:validate_metric] || Metrics::Operations::FindById.new
        @list = deps[:list] || Operations::ListByMetricId.new
      end

      def call(params)
        valid_params = yield @apply_contract.call(params)
        yield @validate_metric.call(valid_params[:metric_id])
        @list.call(valid_params[:metric_id])
      end
    end
  end
end
