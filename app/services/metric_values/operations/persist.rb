module MetricValues
  module Operations
    class Persist
      include App::Operation

      def call(value_record: nil, params:)
        value = value_record || MetricValue.new
        value.assign_attributes(params)
        value.save!

        Success(value)
      rescue ActiveRecord::StatementInvalid
        Failure([:statement_invalid])
      end
    end
  end
end
