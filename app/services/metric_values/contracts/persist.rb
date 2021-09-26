module MetricValues
  module Contracts
    class Persist < App::Contract
      params do
        required(:timestamp).filled(:datetime)
        required(:value).filled(:float)
        required(:metric_id).filled(:string)
      end
    end
  end
end
