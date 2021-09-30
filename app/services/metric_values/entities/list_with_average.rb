module MetricValues
  module Entities
    class ListWithAverage < App::Struct
      attribute :metric_values, App::Types::Array

      attribute :average, App::Struct.meta(omittable: true) do
        attribute :per_minute, App::Types::Float
        attribute :per_hour, App::Types::Float
        attribute :per_day, App::Types::Float
      end
    end
  end
end
