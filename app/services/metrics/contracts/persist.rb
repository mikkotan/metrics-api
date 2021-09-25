module Metrics
  module Contracts
    class Persist < App::Contract
      params do
        required(:name).filled(:string)
      end
    end
  end
end
