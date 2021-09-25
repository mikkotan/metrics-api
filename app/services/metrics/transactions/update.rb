module Metrics
  module Transactions
    class Update
      include App::Transaction

      def initialize(deps = {})
        contract = deps[:contract] || Contracts::Update.new
        @apply_contract = deps[:apply_contract] || App::ApplyContract.new(contract)
        @find_metric = deps[:find_metric] || Operations::FindById.new
        @update = deps[:update] || Operations::Persist.new
      end

      def call(params)
        valid_params = yield @apply_contract.call(params)
        metric = yield @find_metric.call(valid_params[:id])
        @update.call(metric_record: metric, params: valid_params)
      end
    end
  end
end
