module Metrics
  module Contracts
    class Update < App::Contract
      params(Persist.schema) do
        required(:id).filled(:string)
      end
    end
  end
end
