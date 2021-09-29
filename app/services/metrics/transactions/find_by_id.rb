module Metrics
  module Transactions
    class FindById
      include App::Transaction

      def initialize(deps = {})
        @find = deps[:find] || Operations::FindById.new
      end

      def call(id)
        @find.call(id)
      end
    end
  end
end
