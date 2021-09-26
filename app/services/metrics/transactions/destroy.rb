module Metrics
  module Transactions
    class Destroy
      include App::Transaction

      def initialize(deps = {})
        @db = deps[:db] || ActiveRecord::Base
        @find_metric = deps[:find_metric] || Operations::FindById.new
      end

      def call(id)
        metric = yield @find_metric.call(id)
        values = metric.values

        @db.transaction do
          values.destroy_all if values.any?
          metric.destroy
        end

        Success(deleted_metric_id: id)
      end
    end
  end
end
