module Metrics
  module Transactions
    class Create
      include App::Transaction

      def initialize(deps = {})
        contract = deps[:contract] || Contracts::Persist.new
        @apply_contract = deps[:apply_contract] || App::ApplyContract.new(contract)
        @create = deps[:create] || Operations::Persist.new
      end

      def call(params)
        valid_params = yield @apply_contract.call(params)
        @create.call(params: valid_params)
      end
    end
  end
end
