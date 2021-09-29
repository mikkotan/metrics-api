module MetricValues
  module Operations
    class ListByMetricId
      include App::Operation

      def call(metric_id)
        values = MetricValue.where(metric_id: metric_id).order('timestamp ASC')
        Success(values)
      end
    end
  end
end
