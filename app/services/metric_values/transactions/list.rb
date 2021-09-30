module MetricValues
  module Transactions
    class List
      include App::Transaction

      def initialize(deps = {})
        @apply_contract = deps[:apply_contract] || App::ApplyContract.new(Contracts::List.new)
        @validate_metric = deps[:validate_metric] || Metrics::Operations::FindById.new
        @list = deps[:list] || Operations::ListByMetricId.new
        @apply_filter = deps[:apply_filter] || Operations::FilterByTimestamp.new
        @get_avg = deps[:get_avg] || Operations::GetAverageFromList.new
      end

      def call(params)
        valid_params = yield @apply_contract.call(params)

        yield @validate_metric.call(valid_params[:metric_id])

        list = yield @list.call(valid_params[:metric_id])
        filtered_list = yield @apply_filter.call(list, valid_params[:query])
        average = yield @get_avg.call(filtered_list, valid_params[:query])
        entity = Entities::ListWithAverage.new(
          list: filtered_list.to_a,
          average: average
        )

        Success(entity)
      end
    end
  end
end
