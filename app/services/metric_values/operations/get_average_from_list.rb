module MetricValues
  module Operations
    class GetAverageFromList
      include App::Operation

      HOURS = 24
      MINUTES = 60

      def call(collection, query = {})
        return Success(nil) unless query[:from] && query[:to]

        total_values = total_values_from(collection)
        days = calculate_days_from(query)
        hours = get_hours_from(days)
        minutes = get_minutes_from(hours)

        Success({
          per_minute: (total_values / minutes).round(4),
          per_hour: (total_values / hours).round(2),
          per_day: (total_values / days).round(2)
        })
      end

      private

      def total_values_from(collection)
        collection.pluck(:value).sum
      end

      def calculate_days_from(query)
        from = query[:from]
        to = query[:to]
        diff = (from - to).to_i.abs

        diff.zero? ? 1 : diff
      end

      def get_hours_from(days)
        days * HOURS
      end

      def get_minutes_from(hours)
        hours * MINUTES
      end
    end
  end
end
