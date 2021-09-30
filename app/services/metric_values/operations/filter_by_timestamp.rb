module MetricValues
  module Operations
    class FilterByTimestamp
      include App::Operation

      def call(collection, query = nil)
        return Success(collection) if query.nil?

        filtered = collection.where(timestamp: query[:from]..query[:to])
        Success(filtered)
      end
    end
  end
end
