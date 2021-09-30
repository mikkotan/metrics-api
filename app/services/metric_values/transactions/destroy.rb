module MetricValues
  module Transactions
    class Destroy
      include App::Transaction

      def initialize(deps = {})
        contract = deps[:contract] || Contracts::Destroy.new
        @apply_contract = deps[:apply_contract] || App::ApplyContract.new(contract)
        @validate_metric = deps[:validate_metric] || Metrics::Operations::FindById.new
        @find_value = deps[:find_value] || Operations::FindById.new
      end

      def call(params)
        valid_params = yield @apply_contract.call(params)
        metric = yield @validate_metric.call(valid_params[:metric_id])
        value = yield @find_value.call(valid_params[:id])

        value.destroy

        Success(
          metric_id: metric.id,
          id: value.id
        )
      end
    end
  end
end
