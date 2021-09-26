module MetricValues
  module Contracts
    class Destroy < App::Contract
      params do
        required(:id).filled(:string)
        required(:metric_id).filled(:string)
      end
    end
  end
end
