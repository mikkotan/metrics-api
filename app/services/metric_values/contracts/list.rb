module MetricValues
  module Contracts
    class List < App::Contract
      params do
        required(:metric_id).filled(:string)
      end
    end
  end
end
