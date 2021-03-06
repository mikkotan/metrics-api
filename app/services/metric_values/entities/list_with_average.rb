module MetricValues
  module Entities
    class ListWithAverage < App::Struct
      attribute :list, App::Types::Array

      attribute :average do
        attribute :per_minute, App::Types::Coercible::Decimal.meta(omittable: true)
        attribute :per_hour, App::Types::Coercible::Decimal.meta(omittable: true)
        attribute :per_day, App::Types::Coercible::Decimal.meta(omittable: true)
      end
    end
  end
end
