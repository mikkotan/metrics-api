module Api
  module V1
    class ValuesController < ApplicationController
      def index
        result = MetricValues::Transactions::List.new.call(hash_params)
        handle_result(result)
      end

      def create
        result = MetricValues::Transactions::Create.new.call(hash_params)
        handle_result(result, :created)
      end

      def destroy
        result = MetricValues::Transactions::Destroy.new.call(hash_params)
        handle_result(result)
      end
    end
  end
end
