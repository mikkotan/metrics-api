module MetricValues
  module Operations
    class FindById
      include App::Operation

      def call(id)
        value = MetricValue.where(id: id).limit(1).first

        if value
          Success(value)
        else
          Failure([:not_found, 'Metric value not found'])
        end
      end
    end
  end
end
