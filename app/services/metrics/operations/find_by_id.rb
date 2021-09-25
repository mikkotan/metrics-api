module Metrics
  module Operations
    class FindById
      include App::Operation

      def initialize(deps = {})
        @klass = deps[:klass] || Metric
      end

      def call(id)
        metric = @klass.where(id: id).limit(1).first

        if metric
          Success(metric)
        else
          Failure([:not_found, 'Metric not found'])
        end
      end
    end
  end
end
