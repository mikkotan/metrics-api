module MetricValues
  module Contracts
    class List < App::Contract
      params do
        required(:metric_id).filled(:string)

        optional(:query).schema do
          required(:from).filled(:date_time)
          required(:to).filled(:date_time)
        end
      end
    end
  end
end
