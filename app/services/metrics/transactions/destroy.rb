module Metrics
  module Transactions
    class Destroy
      include App::Transaction

      def initialize(deps = {})
        @find_metric = deps[:find_metric] || Operations::FindById.new
      end

      def call(id)
        metric = yield @find_metric.call(id)
        metric.destroy
        Success(deleted_metric_id: id)
      end
    end
  end
end
