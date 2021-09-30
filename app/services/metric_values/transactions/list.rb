module MetricValues
  module Transactions
    class List
      include App::Transaction

      def initialize(deps = {})
        contract = deps[:contract] || Contracts::List.new
        @apply_contract = deps[:apply_contract] || App::ApplyContract.new(contract)
        @validate_metric = deps[:validate_metric] || Metrics::Operations::FindById.new
        @list = deps[:list] || Operations::ListByMetricId.new
        @apply_filter = deps[:apply_filter] || Operations::FilterByTimestamp.new
      end

      def call(params)
        valid_params = yield @apply_contract.call(params)
        yield @validate_metric.call(valid_params[:metric_id])
        list = yield @list.call(valid_params[:metric_id])

        if valid_params[:query]
          query = valid_params[:query]

          @apply_filter.call(
            collection: list,
            from: query[:from],
            to: query[:to]
          )
        else
          Success(list)
        end
      end
    end
  end
end
