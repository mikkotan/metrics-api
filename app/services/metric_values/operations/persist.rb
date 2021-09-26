module MetricValues
  module Operations
    class Persist
      include App::Operation

      def call(value_record: nil, params:)
        value = value_record || MetricValue.new

        value.metric_id = params[:metric_id]
        value.timestamp = params[:timestamp]
        value.value = params[:value]
        value.save!

        Success(value)
      rescue ActiveRecord::RecordInvalid
        Failure([:invalid_record, value.errors.full_messages])
      end
    end
  end
end
