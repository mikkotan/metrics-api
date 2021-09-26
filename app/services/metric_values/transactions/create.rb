module MetricValues
  module Transactions
    class Create
      include App::Transaction

      def initialize(deps = {})
        contract = deps[:contract] || Contracts::Persist.new
        @apply_contract = deps[:apply_contract] || App::ApplyContract.new(contract)
        @validate_metric = deps[:validate_metric] || Metrics::Operations::FindById.new
        @create = deps[:create] || Operations::Persist.new
      end

      def call(params)
        valid_params = yield @apply_contract.call(params)
        yield @validate_metric.call(valid_params[:metric_id])
        @create.call(params: valid_params)
      end
    end
  end
end
