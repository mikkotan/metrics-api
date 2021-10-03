module MetricValues
  module Contracts
    class List < App::Contract
      params do
        required(:metric_id).filled(:string)

        optional(:from).maybe(:date_time)
        optional(:to).maybe(:date_time)
      end
    end
  end
end
