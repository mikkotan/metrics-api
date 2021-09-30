module MetricValues
  module Operations
    class FilterByTimestamp
      include App::Operation

      def call(collection:, from:, to:)
        filtered_collection = collection.where(timestamp: from..to)
        Success(filtered_collection)
      end
    end
  end
end
