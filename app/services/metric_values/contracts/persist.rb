module MetricValues
  module Contracts
    class Persist < App::Contract
      params do
        required(:timestamp).filled(:date_time)
        required(:value).filled(:decimal)
        required(:metric_id).filled(:string)
      end
    end
  end
end
